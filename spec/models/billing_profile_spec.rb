require 'spec_helper'

describe BillingProfile do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    BillingProfile.create!(@valid_attributes)
  end
end
