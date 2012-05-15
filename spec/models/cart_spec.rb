require 'spec_helper'

describe Cart do

  before(:each) do
    @cart = Cart.new
    @category = Factory(:category)
    @product = Factory.build(:product , :category_id => @category.id)
  end  
  
  it "should have attribute accessor" do
    @cart.cart_items.should be_nil
    @cart.cart_items = [1]
    @cart.cart_items.should_not be_nil
  end    

  it "should be able to add product" do
    @cart.add_product(@product)
    @cart.cart_items.size.should == 1
  end  
  
  it "should only increase the quantity of the product if it already exists in the cart" do
    @cart.add_product(@product)
    @cart.cart_items.size.should == 1
    @cart.cart_items[@product.id].should == 1
    @cart.add_product(@product)
    @cart.cart_items.size.should == 1
    @cart.cart_items[@product.id].should == 2
  end  
  
  it "should return the total price of all the products in the cart" do
    @cart.add_product(@product)
    @cart.cart_price.should == @product.price
    @cart.add_product(@product)
    @cart.cart_price.should == @product.price * @cart.cart_items[@product.id]
  end  
  
  it "should reutrn all the products in the cart with there quantity" do
    @cart.add_product(@product)
    debugger
    @products = [[@product,@cart.cart_items[@product.id]]]
    @cart.show_cart.should == @products
  end      
end  