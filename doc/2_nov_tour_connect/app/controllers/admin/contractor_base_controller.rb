class Admin::ContractorBaseController < Admin::BaseController
  before_filter :ensure_contractor
end
