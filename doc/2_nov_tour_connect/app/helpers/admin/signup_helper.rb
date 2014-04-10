module Admin::SignupHelper
  def error_message_targets_for_signup(obj)
    targets = [obj, obj.corporate_information]
    targets += obj.corporate_locations.to_a
    targets += obj.contact_groups.to_a
    targets += obj.contact_groups.collect(&:contacts).flatten

    if obj.is_a?(Supplier)
      targets << obj.supplier_term
      targets << obj.insurance_information
    end

    targets
  end
end
