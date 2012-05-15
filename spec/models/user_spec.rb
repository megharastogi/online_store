require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory(:user, :account => Factory(:account2))
  end  
  
  it "should have one account" do
    @user.should have_one(:account)
  end
  
  it "should have nested attributes of account" do
    @user.respond_to?('account_attributes=').should be_true
  end  
  
  it "should not accept invalid values for account" do
    @user.account.name = ""
    @user.account.should_not be_valid
  end
  
end
