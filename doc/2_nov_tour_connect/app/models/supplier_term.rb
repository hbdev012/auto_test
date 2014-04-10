class SupplierTerm < CompanyTerm

## Associations
  embedded_in :termable, :polymorphic => true
end