class Property
  include Mongoid::Document
  include Mongoid::Timestamps

## Associations
  belongs_to :supplier

  with_options :dependent => :destroy, :autosave => true do |property|
    property.has_many :bonus_offers,   :as => :bonus_offerable
    property.has_many :contact_groups, :as => :contact_groupable, :order => [[:admin_group, :desc], [:initial_group, :desc], [:name, :asc]]
    property.has_many :products
    property.has_many :images, :as => :imageable
    property.has_many :property_locations
    property.has_many :seasons
  end

  embeds_one :billing_information,   :as => :billable
  embeds_one :insurance_information, :as => :insurable
  embeds_one :property_policy
  embeds_one :supplier_term,         :as => :termable

  with_options :allow_destroy => true do |property|
    property.accepts_nested_attributes_for :bonus_offers
    property.accepts_nested_attributes_for :contact_groups
    property.accepts_nested_attributes_for :products
    property.accepts_nested_attributes_for :images
    property.accepts_nested_attributes_for :property_locations
    property.accepts_nested_attributes_for :seasons
  end

## Constants
  DEFAULT_CONTACT_GROUPS = %w(Sales Billing Reservations).freeze

## Fields
  with_options :type => Boolean do |property|
    property.field :conforms_to_eu

    property.with_options :default => true do |corporate_property|
      corporate_property.field :use_corporate_billing_information
      corporate_property.field :use_corporate_insurance_information
      corporate_property.field :use_corporate_supplier_term
    end
  end

  with_options :type => String do |property|
    property.field :long_description
    property.field :name
    property.field :short_description
  end

## Validations
  with_options :presence => true do |property|
    property.validates :long_description,  :length => { :maximum => 1000 }
    property.validates :name
    property.validates :short_description, :length => { :maximum => 250 }
  end

  validate :overlapping_dates

## Instance Methods
  def has_season_gaps?
    year_begins = Time.zone.now.at_beginning_of_year.to_date
    year_ends   = Time.zone.now.at_end_of_year.to_date
    seasons     = self.seasons.in_range(year_begins, year_ends).asc(:begins_on)

    if seasons.empty?
      return true
    elsif seasons.length == 1
      return true if seasons.first.begins_on > year_begins or seasons.first.ends_on < year_ends
    else
      seasons.to_a.each_with_index do |season, index|
        if index.zero?
          return true if season.begins_on > year_begins
        elsif index == (seasons.length - 1)
          return true if season.ends_on < year_ends or (season.begins_on.beginning_of_day - seasons[index - 1].ends_on.end_of_day) > 0
        else
          return true if (season.begins_on.beginning_of_day - seasons[index - 1].ends_on.end_of_day) > 0
        end
      end
    end

    seasons.first.begins_on > year_begins && seasons.last.ends_on < year_ends
  end

  def prepare_property
    initialize_dependencies
  end

  [:billing_information, :insurance_information, :supplier_term].each do |corporate_info|
    define_method("#{corporate_info}_with_corporate") do
      current       = self.send(:"#{corporate_info}_without_corporate")
      use_corporate = self.send(:"use_corporate_#{corporate_info}?")

      if current.nil?
        use_corporate ? self.supplier.send(corporate_info) : current
      else
        if current.new_record?
          current
        else
          use_corporate ? self.supplier.send(corporate_info) : current
        end
      end
    end

    alias_method_chain corporate_info, :corporate
  end

private

  def initialize_dependencies
    self.build_property_policy     if self.property_policy.nil?
    self.build_billing_information if self.billing_information_without_corporate.nil?
    self.build_supplier_term       if self.supplier_term_without_corporate.nil?
    self.property_locations.build  if self.property_locations.empty?

    if self.insurance_information_without_corporate.nil?
      ins_info = self.build_insurance_information
      ins_info.insurance_documents.build
    end

    DEFAULT_CONTACT_GROUPS.each do |group|
      if self.contact_groups.to_a.detect { |cg| cg.name == group && cg.initial_group == true }.nil?
        default_group = self.contact_groups.build :name => group, :initial_group => true
        default_group.contacts.build
      end
    end
  end

  def overlapping_dates
    self.seasons.each do |season|
      self.errors.add(:seasons, " - #{season.name} overlaps with another season") if season.overlap?(self.seasons)
    end
  end

end
