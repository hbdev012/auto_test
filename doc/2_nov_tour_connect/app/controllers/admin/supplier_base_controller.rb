class Admin::SupplierBaseController < Admin::BaseController
  before_filter :ensure_supplier
end
