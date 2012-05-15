class CartsController < ApplicationController
  
  def show
    session[:cart].cart_items.blank? ? @products = [] : @products = session[:cart].show_cart
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_with_flash("notice", "Your cart is now empty", root_path)
  end  

  def remove_product
    session[:cart].cart_items.delete(params[:id].to_i)
    redirect_with_flash("notice", "Product has been removed from cart", cart_path)
  end  

  
  def change_cart_values
    @error_fields = []
    @cart_items.each_key do |product|
      p =  product.to_s + "_quantity"
      session[:cart].update_cart(product,params[p]) == "error" ?   @error_fields << p : ""
    end    
    @products = session[:cart].show_cart
    if @error_fields.blank?
      redirect_to cart_path
    else
      flash.now[:error] = "Quantity can only be a number greater than 0" 
      render :action => "show"
    end    
  end
  
end
