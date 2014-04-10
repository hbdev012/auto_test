module Admin::ContactGroupHelper
  def contact_group_fieldset_id(contact_group)
    if contact_group.name.present?
      "#{ contact_group.name.downcase.gsub(' ', '-') }-contact-group"
    else
      "-contact-group"
    end
  end
end
