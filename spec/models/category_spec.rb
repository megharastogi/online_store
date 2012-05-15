require 'spec_helper'

describe Category do
  
  before(:each) do
    @category = Factory(:category)
  end
  
  it "should validate presence of name" do
    @category.should validate_presence_of(:name)
  end
  
  it "should validate uniqueness of name" do
    @category1 = Category.new(:name => "category")
    @category1.should_not be_valid
  end  
      
end
