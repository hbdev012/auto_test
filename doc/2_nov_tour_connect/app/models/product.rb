class Product
  include Mongoid::Document
  include Mongoid::Timestamps

## Associations
  belongs_to :property
  belongs_to :supplier

  has_many :images, :as => :imageable, :dependent => :destroy, :autosave => true

  accepts_nested_attributes_for :images, :allow_destroy => true

## Fields
  with_options :type => String do |product|
    product.field :name
    product.field :code
    product.field :short_description
    product.field :details
  end

## Validations
  validates :name, :property, :presence => true

end
