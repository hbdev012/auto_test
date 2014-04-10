class BillingInformation
  include Mongoid::Document

## Associations
  embedded_in :billable, :polymorphic => true

## Fields
  with_options :type => String do |billing_info|
    billing_info.field :account_name
    billing_info.field :account_number
    billing_info.field :bank_name
    billing_info.field :branch
    billing_info.field :code
    billing_info.field :currency
    billing_info.field :routing_number
    billing_info.field :tax
    billing_info.field :terms
  end

end