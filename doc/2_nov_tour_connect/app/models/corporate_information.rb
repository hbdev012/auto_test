class CorporateInformation
  include Mongoid::Document

## Associations
  embedded_in :company

## Image Uploads
  image_accessor :logo

## Fields
  field :description, :type => String
  field :logo_name,   :type => String
  field :logo_uid,    :type => String

## Validations
  validates          :description, :presence => true
  validates_size_of  :logo, :maximum => 300.kilobytes
  validates_property :format, :of => :logo, :in => [:jpg, :jpeg, :png, :gif]

end
