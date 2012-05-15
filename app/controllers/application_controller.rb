class ApplicationController < ActionController::Base
  
  
  before_filter :load_categories, :find_cart, :cart_values
  
  protect_from_forgery :secret => '8fc080370e56e929a2d5afca5540a0f7'
  
  filter_parameter_logging :password 
    
  include AuthenticatedSystem
  
  helper :all
  
  def load_categories
    @categories = Category.all
  end  
  
  def cart_values 
    if !session[:cart].blank? && !session[:cart].cart_items.blank?
      @cart_items = session[:cart].cart_items
      @cart_price = session[:cart].cart_price
    else
      @cart_items = {}
      @cart_price = 0
    end    
  end
  
  def redirect_with_flash(flash_type, flash_msg, returnpath)
    flash[flash_type.to_sym] = flash_msg
    return redirect_to returnpath
  end 
    
  protected

  def authorize
    redirect_with_flash("notice", "You must be logged in", login_path) unless logged_in?
  end 
  
  def find_cart 
    session[:cart] ||= Cart.new
  end  	
  
  def authorize_as_admin
    redirect_with_flash("notice", "You must be logged in as Admin", root_path) unless ( !!current_account && current_account.admin? ) 
  end
  
  def layout_type
    (current_account && current_account.admin?) ?  "admin" :  "application"
  end 
  
end
