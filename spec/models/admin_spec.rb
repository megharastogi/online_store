require 'spec_helper'

describe Admin do
  
  before(:each) do
    @admin = Factory(:admin, :account => Factory(:account1))
  end
  
  it "should have one account" do
    @admin.should have_one(:account)
  end  
  
  it "should validate presence of role" do
    @admin.should validate_presence_of(:role)
  end  
  
  it "should have nested attributes of account" do
    @admin.respond_to?('account_attributes=').should be_true
  end  
  
  it "should not accept invalid values for account" do
    @admin.account.name = ""
    @admin.should_not be_valid
  end  
end
