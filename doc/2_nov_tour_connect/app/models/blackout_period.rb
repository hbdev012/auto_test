class BlackoutPeriod < NamedDateRange

## Associations
  embedded_in :blackoutable, :polymorphic => true

## Validations
  validates :begins_on, :inclusion => { :in => lambda { |b| (b.blackoutable.begins_on .. b.blackoutable.ends_on) }, :message => 'must be within season date range' }
  validates :ends_on,   :inclusion => { :in => lambda { |b| (b.blackoutable.begins_on .. b.blackoutable.ends_on) }, :message => 'must be within season date range' }

end
