class SimpleDateRange
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

## Scopes
  scope :in_range, lambda { |begins, ends| any_of({ :begins_on.gte => begins.to_time, :begins_on.lte => ends.to_time }, { :ends_on.gte => begins.to_time, :ends_on.lte => ends.to_time }) }

## Fields
  field :begins_on, :type => Date, :default => lambda { Time.zone.now.to_date }
  field :ends_on,   :type => Date, :default => lambda { Time.zone.now.to_date }

## Validations
  validates :begins_on, :ends_on, :presence => true
  validate  :proper_date_range

  def overlap?(collection)
    if self.begins_on.present? and self.ends_on.present?
      range = (self.begins_on .. self.ends_on)
      collection.any? do |c|
        next if c == self
        range.include?(c.begins_on) or range.include?(c.ends_on)
      end
    else
      false
    end
  end

private

  def proper_date_range
    if self.begins_on.present? and self.ends_on.present?
      self.errors.add :begins_on, 'must be on or before end date' if self.begins_on > self.ends_on
    end
  end
end
