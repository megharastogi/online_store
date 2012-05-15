require 'spec_helper'

describe OrdersController do

  before(:each) do
    @order = mock_model(Order,:id =>1 ,:save => true)
    @cart = mock_model(Cart)
    @product = Factory(:product , :category_id => Factory(:category))
    Cart.should_receive(:new).and_return(@cart)
    @user = Factory(:user , :account => Factory(:account2))
    @account = @user.account
  end  
  
  it "should give proper error message if visitor press checkout with empty cart" do
    @cart.should_receive(:cart_items).twice.and_return(@cart_items = [])
    @cart_items.should_receive(:blank?).twice.and_return(true)
    post :checkout
    response.should be_redirect
    response.should redirect_to products_path
    flash[:notice].should == "Your cart is empty. You should have atleast one item before checkout"
  end  
  
  it "should redirect user to login path if user is not logged and cart is not empty" do
    @cart.should_receive(:cart_items).twice.and_return(@cart_items = [{:product_id => @product.id , :quantity => 1 }])
    @cart_items.should_receive(:blank?).and_return(false)
    @cart.should_receive(:cart_price).and_return(@product.price)
    @cart.should_receive(:cart_items).and_return(@cart_items = [{:product_id => @product.id , :quantity => 1 }])
    post :checkout
    response.should be_redirect
    response.should redirect_to login_path
    flash[:notice].should == "Please login to place your order"
  end  

  it "should create a order if user is logged in and have products in cart" do
    @cart.should_receive(:cart_items).exactly(3).times.and_return(@cart_items = [{:product_id => @product.id , :quantity => 1 }])
    @cart.should_receive(:cart_price).and_return(@product.price)
    @cart_items.should_receive(:blank?).and_return(false)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:current_account).and_return(@account)
    @account.should_receive(:admin?).and_return(false)
    Order.should_receive(:add_order_items).and_return(@order,@products)
    post :checkout
    response.should redirect_to order_path(@order)
    flash[:notice].should == "Your order has been created"
  end  
  
end
