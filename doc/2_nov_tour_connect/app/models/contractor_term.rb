class ContractorTerm < CompanyTerm
## Associations
  embedded_in :contractor

## Fields
  with_options :type => String do |contractor_term|
    contractor_term.field :submission_criteria
    contractor_term.field :title
  end

## Validations
  with_options :presence => true do |contractor_term|
    contractor_term.validates :submission_criteria
    contractor_term.validates :title
  end
end