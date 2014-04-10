require 'spec_helper'

describe Contractor do

  before do
    user = Factory.create :user, :company_attributes => { :name => 'Planet Express', :_type => 'Contractor', :country => 'Australia' }
    user.confirm!
    @contractor = user.reload.company
  end

end
