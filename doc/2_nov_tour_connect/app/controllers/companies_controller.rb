class CompaniesController < ApplicationController

  respond_to :json

  def index
    name = (params[:company] || {}).delete(:name)

    @companies = Company.where(params[:company]).where(:name => /^#{ name }/i).asc(:name).limit(5)

    respond_with @companies
  end

end