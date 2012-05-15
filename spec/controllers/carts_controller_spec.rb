require 'spec_helper'

describe CartsController do

  before(:each) do
    @cart = mock_model(Cart)
    @product = Factory(:product , :category_id => Factory(:category))
    Cart.should_receive(:new).and_return(@cart)
    @cart_items = { @product.id => 1}
    @cart.should_receive(:cart_items).twice.and_return(@cart_items)
    @cart.should_receive(:cart_price).and_return(@product.price)
    @p = @product.id.to_s + "_quantity"
  end  

  it "should allow visitor/user to access show action" do
    @cart.should_receive(:cart_items).and_return(@cart_items)
    @cart.should_receive(:show_cart).and_return(@products)
    get :show
    response.should be_success
    response.should render_template 'show'
  end  
  
  it "should allow visitor/user to empty the cart" do
     get :empty_cart
     response.should redirect_to root_path
     flash[:notice].should == "Your cart is now empty"
  end  
  
  it "should allow visitor/user to access edit action for each product in cart" do
    get :edit ,{:id => @product.id}
    response.should render_template 'edit'
  end

  it "should not allow visitor/user to change the quantity of the product to nil" do
     post :change_cart_values ,{ @p => '0'}
     response.should be_redirect
     response.should redirect_to cart_path(@product) 
     flash[:notice].should == "Quantity cant be blank"
   end
  
  it "should not allow visitor/user to change the quantity of the product to invalid value" do
    post :change_cart_values ,{ @p  => 'asd'}
    response.should be_redirect
    response.should redirect_to cart_path(@product) 
    flash[:notice].should == "Quantity can only be a number greater than 0"
  end  
  
  it "should allow visitor/user to change the quantity of the product with valid value" do
    post :change_cart_values ,{ @p => '3'}
    response.should be_redirect
    response.should redirect_to cart_path
    flash[:notice].should == "Your cart has been updated"
  end  
   
  it "should allow visitor/user to remove a product from the list" do
    @cart.should_receive(:cart_items).and_return([])
    get :remove_product , {:id => @product.id}
    response.should redirect_to cart_path
    flash[:notice].should == "Product has been removed from cart"
  end
  
end

