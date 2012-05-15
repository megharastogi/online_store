class OrdersController < ApplicationController
  
  before_filter :store_location
  before_filter :authorize , :only => [:show , :order_payment]

  def checkout
    if session[:cart].cart_items.blank?
      redirect_with_flash("notice", "Your cart is empty. You should have atleast one item before checkout", products_path)
    else
      if logged_in? && !current_account.admin?
        @order,@products = Order.add_order_items(current_account.resource_id,@cart_items)
        session[:cart] = nil
        redirect_with_flash("notice","Your order has been created", order_path(@order))
      else
        redirect_with_flash("notice","Please login to place your order", login_path)
      end    
    end
  end  
  
  def show
    @order = Order.find_by_id(params[:id])
    @products = @order.order_products
    @total = @order.order_price
  end  
  
  def order_payment 
    @order = Order.find_by_id(params[:id])   
    if @order.transaction_id.blank?
        if current_account.resource.customer_profile_id.blank?
            return redirect_to create_new_customer_profile_user_path
        else
            @user = current_account.resource
        end
    else
        redirect_to order_path(@order)
    end        
  end
end
