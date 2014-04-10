class InsuranceDocument
  include Mongoid::Document

## File Uploads
  image_accessor :attachment

## Associations
  embedded_in :insurance_information

## Fields
  with_options :type => String do |ins_doc|
    ins_doc.field :attachment_uid
    ins_doc.field :attachment_name
  end

## Validations
  validates_property :format, :of => :attachment, :in => [:pdf, :jpg, :jpeg, :tiff, :doc, :docx]

end
