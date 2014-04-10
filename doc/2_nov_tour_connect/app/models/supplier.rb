class Supplier < Company

## Associations
  has_many :properties, :dependent => :destroy
  has_many :products,   :dependent => :destroy

  embeds_one :supplier_term, :as => :termable
  embeds_one :supplier_corporate_information
  embeds_one :insurance_information, :as => :insurable

## Constants
  DEFAULT_AMENITIES = ['Babysitting', 'Barbecue', 'Children\'s Play Area', 'Dry Cleaning', 'Wi-Fi Internet', 'Swimming Pool', '24 Hour Security']

## Fields
  field :amenities, :type => Array, :default => DEFAULT_AMENITIES

private

  def initialize_dependencies
    super

    self.build_supplier_corporate_information if self.supplier_corporate_information.nil?
    self.build_supplier_term if self.supplier_term.nil?

    if self.insurance_information.nil?
      ins_info = self.build_insurance_information
      ins_info.insurance_documents.build
    end
  end

end