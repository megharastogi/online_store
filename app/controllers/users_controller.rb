class UsersController < ApplicationController
  
  #fix no need to put bracket for one action
  #fixed
  before_filter :authorize , :only => [:show, :new_billing_profile, :create_new_customer_profile, :create_new_customer_profile_on_authorize, :create_new_payment_profile ,:new_shipping_profile ,:update_billing_profile]
  before_filter :load_user , :only => [:create_new_customer_profile_on_authorize, :create_new_payment_profile ,:update_billing_profile,:update_shipping_profile]
  before_filter :load_current_user , :only => [:new_billing_profile,:new_shipping_profile ,:create_new_customer_profile ,:edit_billing_profile ,:edit_shipping_profile]
 
  def index
  end  
 
  def new
    @user = User.new
  end  
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.account.generate_activation_token 
      #fix - message should say 'Please check you mail for the activation link'
      #fixed
      redirect_with_flash("notice", "Please check you mail for the activation link", root_path)
    else
      render :action => 'new'
    end    
  end
  
  def show
    #fix we can use current_account here
    #fixed
    @account = current_account
  end  
  
  def create_new_customer_profile
      
  end  
  
  def create_new_customer_profile_on_authorize  
    @user.attributes = params[:user]
    if @user.valid?
        @response = @user.create_customer_profile_on_authorize
        if @response.success?
           return redirect_to user_path(@user)
        else    
          flash.now[:error] = @response.message
          render :action => "create_new_customer_profile"
        end  
    else
        render :action => "create_new_customer_profile"
    end    
  end
  
  def create_new_payment_profile
    @user.attributes = params[:user]
    @response =  @user.create_new_payment_profile_on_authorize
    return redirect_to root_path
  end
  
  def new_shipping_profile
    @user.attributes = params[:user]
    if request.put?
        if @user.valid?
            @response =  @user.new_shipping_profile_on_authorize
            return redirect_to user_path(@user)
        else
            render :action => "new_shipping_profile"
        end        
    end
  end   
  
  def new_billing_profile
      @user.attributes = params[:user]
      if request.put?
          if @user.valid?
              @response =  @user.new_billing_profile_on_authorize
              return redirect_to user_path(@user)
          else
              render :action => "new_billing_profile"
          end        
      end
  end   
    
  def edit_billing_profile
   @billing_profile = BillingProfile.find_by_id(params[:id])
   @payment_profile = GATEWAY.get_customer_payment_profile(:customer_profile_id => @user.customer_profile_id ,:customer_payment_profile_id => @billing_profile.customer_payment_profile_id)    
  end        
  
  def edit_shipping_profile
      @shipping_profile = ShippingProfile.find_by_id(params[:id])
  end      
  
  def update_shipping_profile
      @shipping_profile = ShippingProfile.find_by_id(params[:user]["shipping_profiles_attributes"]["0"]["id"])
      @shipping_profile.attributes = params[:user]["shipping_profiles_attributes"]["0"]
      if @shipping_profile.valid?
          @response = GATEWAY.update_customer_shipping_address({:customer_profile_id => @user.customer_profile_id ,:address => @shipping_profile.shipping_address.merge({:customer_address_id => @shipping_profile.customer_address_id})} )
          if @response.success?
            @shipping_profile.update_attributes(params[:user]["shipping_profiles_attributes"]["0"])
            redirect_to user_path(@user)    
          else
             flash.now[:error] = @response.message
             render :action => "edit_shipping_profile"
          end
      else
          render :action => "edit_shipping_profile"
      end                
  end      
  
  def update_billing_profile
      @billing_profile = BillingProfile.find_by_id(params[:user]["billing_profiles_attributes"]["0"]["id"])
      @billing_profile.attributes = params[:user]["billing_profiles_attributes"]["0"]
      if @billing_profile.valid?
          @response = GATEWAY.update_customer_payment_profile({:customer_profile_id => @user.customer_profile_id ,:payment_profile => @billing_profile.payment_profiles.merge({:customer_payment_profile_id => @billing_profile.customer_payment_profile_id})} )
          if @response.success?
              @billing_profile.update_attributes(params[:user]["billing_profiles_attributes"]["0"])
              redirect_to user_path(@user)
          else
              flash.now[:error] = @response.message
              render :action => "edit_billing_profile"
          end            
      else
          render :action => "edit_billing_profile"
      end            
  end      
  
  def money_transcation
    unless params[:selected_billing_profile] && params[:selected_shipping_profile]
        redirect_with_flash("error", "Please Select one billing and shipping address", order_payment_order_path(params[:order_id]))
    end    
    @order = Order.find_by_id(params[:order_id])
    @billing_profile = BillingProfile.find_by_id(params[:selected_billing_profile])
    @response = GATEWAY.create_customer_profile_transaction(:transaction => {:type => :auth_capture ,:amount => @order.order_price , :customer_profile_id => current_account.resource.customer_profile_id ,:customer_payment_profile_id => @billing_profile.customer_payment_profile_id })
    if @response.success?
        @order.update_attribute('transaction_id',@response.params["direct_response"]["transaction_id"])
        redirect_with_flash("notice", "Payment has been made", order_path(params[:order_id]))
    else
        redirect_with_flash("error", "#{@response.message}", order_payment_order_path(params[:order_id]))
    end
        
  end      
  
  private
  
    def load_current_user
        @user = User.find_by_id(current_account.resource_id)
    end    
  
    def load_user
        @user = User.find_by_id(params[:id])
    end    
end
