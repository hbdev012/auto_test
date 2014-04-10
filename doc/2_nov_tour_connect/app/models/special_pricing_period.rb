class SpecialPricingPeriod < NamedDateRange

## Associations
  embedded_in :special_priceable, :polymorphic => true
  embeds_one  :price_info,        :as => :priceable

## Fields
  field :inherited_id, :type => String

## Validations
  with_options :inclusion => { :in => lambda { |s| (s.special_priceable.begins_on .. s.special_priceable.ends_on) }, :message => 'must be within season date range', :if => lambda { |s| s.special_priceable.present? } } do |special_pricing_period|
    special_pricing_period.validates :begins_on
    special_pricing_period.validates :ends_on
  end

  def inherits?
    self.inherited_id.present?
  end

  [:name, :begins_on, :ends_on].each do |a|
    define_method("#{a}_with_inherited") do
      if self.inherits?
        if self.special_priceable.is_a?(Season)
          self.special_priceable
        else
          self.special_priceable.season
        end.special_pricing_periods.find(self.inherited_id).send(a)
      else
        self.send(:"#{a}_without_inherited")
      end
    end

    alias_method_chain a, :inherited
  end
end
