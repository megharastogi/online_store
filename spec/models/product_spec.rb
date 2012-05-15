require 'spec_helper'

describe Product do
  
  before(:each) do
    @product = Product.new
  end
  
  it "should have many images" do
    @product.should have_many(:images)
  end  
  
  it "should belong to a category" do
    @product.respond_to?('category').should be_true
  end  
  
  it "should have nested attributes of images" do
    @product.respond_to?('images=').should be_true
  end  
  
  [:name , :description , :price ,:quantity,:dimension,:weight,:sku,:category_id].each do |attr|
    it "should validate presence of #{attr.to_s}" do
      @product.should validate_presence_of(attr)
    end
  end  
  
  it "should validate numericality of quantity" do
    @product1 = Factory.build(:product , :quantity => "qw")
    @product1.should_not be_valid
  end
  
  it "should validate numericality of weight" do
    @product1 = Factory.build(:product , :weight => "qw")
    @product1.should_not be_valid
  end
  
  it "should validate uniqueness of name" do
    @product1 = Factory.build(:product)
    @product2 = Product.new(:name => "product1")
    @product2.should_not be_valid
  end
  

  it "should validate inclusion of category_id" do
    @product1 = Factory.build(:product , :category_id => "")
    @product1.should_not be_valid
  end
  
  it "should return blank array if main image of product doesnt exists" do
     @product = Factory.build(:product)
     @image_kind= @product.image_type(2)
     @image_kind.should == []
   end
  
  it "should return main_image if main image of product exists" do
    @product = Factory.build(:product ,:images => [Factory(:image1)])
    @image_kind= @product.image_type(1)
    @image_kind.kind.should == "1"
  end
  
end
