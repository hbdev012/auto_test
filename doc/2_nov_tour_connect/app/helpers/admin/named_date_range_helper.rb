module Admin::NamedDateRangeHelper
  def calendar_preview(obj)
    seasons   = obj.seasons.in_range(Time.zone.now.at_beginning_of_year, Time.zone.now.at_end_of_year).asc(:begins_on)
    blackouts = seasons.collect(&:blackout_periods).flatten.sort_by(&:begins_on)
    specials  = seasons.collect(&:special_pricing_periods).flatten.sort_by(&:begins_on)

    render :partial => 'admin/named_date_ranges/calendar_preview', :locals => {
      :seasons   => date_ranges_for_calendar_preview(seasons),
      :blackouts => date_ranges_for_calendar_preview(blackouts),
      :specials  => date_ranges_for_calendar_preview(specials)
    }
  end

  def date_ranges_for_calendar_preview(ranges)
    if ranges.empty?
      # Single gap entry that spans the whole year.
      [NamedDateRange.new(:begins_on => Time.zone.now.beginning_of_year.to_date, :ends_on => Time.zone.now.end_of_year.to_date)]
    else
      [].tap do |expanded_ranges|
        ranges.to_a.each_with_index do |range, index|

          if index.zero?
            # Look for a gap between this entry and the beginning of the year.
            insert_gap(expanded_ranges, range.begins_on, Time.zone.now.beginning_of_year.to_date - 1.day)
          else
            # Look for a gap between this entry and the previous entry.
            insert_gap(expanded_ranges, range.begins_on, ranges[index-1].ends_on)
          end

          expanded_ranges << range

          if index == (ranges.length - 1)
            # Look for a gap between this entry and the end of the year
            insert_gap(expanded_ranges, Time.zone.now.end_of_year.to_date + 1.day, range.ends_on)
          end
        end
      end
    end
  end

  def percent_of_year(range)
    year_begins = Time.zone.now.at_beginning_of_year
    year_ends   = Time.zone.now.at_end_of_year

    begins = range.begins_on.beginning_of_day < year_begins ? year_begins : range.begins_on.beginning_of_day
    ends   = range.ends_on.end_of_day > year_ends ? year_ends : range.ends_on.end_of_day

    e = BigDecimal.new(ends.to_i.to_s)
    b = BigDecimal.new(begins.to_i.to_s)
    d = BigDecimal.new('86400')
    y = BigDecimal.new('365')
    p = BigDecimal.new('100')

    percent = ((e - b) / d) / y * p
    "#{percent}%"
  end

private

  def insert_gap(ranges, begins, ends)
    b = begins.beginning_of_day
    e = ends.end_of_day

    if begins != ends and (b - e) > 0
      ranges << NamedDateRange.new(:begins_on => ends + 1.day, :ends_on => begins - 1.day)
    end
  end
end
