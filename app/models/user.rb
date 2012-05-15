class User < ActiveRecord::Base

  include ActiveMerchant::Billing::CreditCardMethods
  
  has_one :account, :as => :resource, :dependent => :destroy 
  has_many :billing_profiles
  has_many :shipping_profiles
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :billing_profiles, :update_only => true  
  accepts_nested_attributes_for :shipping_profiles
  has_many :orders
  
  def find_customer_profile
    if self.customer_profile_id
      @customer_profile = GATEWAY.get_customer_profile(:customer_profile_id => self.customer_profile_id)
    else
      @customer_profile = []
    end    
    return @customer_profile
  end  
  
  def create_customer_profile_on_authorize
    @response = GATEWAY.create_customer_profile({:profile => {:payment_profiles =>self.billing_profiles.first.payment_profiles , :ship_to_list => self.shipping_profiles.first.shipping_address, :email => self.account.email}})
    if @response.success?
        self.update_attribute('customer_profile_id' , @response.params["customer_profile_id"])
        self.billing_profiles.first.update_attribute('customer_payment_profile_id', @response.params["customer_payment_profile_id_list"]["numeric_string"])
        self.shipping_profiles.first.update_attribute('customer_address_id', @response.params["customer_shipping_address_id_list"]["numeric_string"])
    end    
    return @response
  end  
  
  def new_billing_profile_on_authorize
    @response =  GATEWAY.create_customer_payment_profile(:customer_profile_id => self.customer_profile_id, :payment_profile => self.billing_profiles.last.payment_profiles )
    if @response.success?
        self.billing_profiles.last.update_attribute('customer_payment_profile_id', @response.params["customer_payment_profile_id"])
    end 
    return @response  
  end      
  
  def new_shipping_profile_on_authorize
      @response =  GATEWAY.create_customer_shipping_address(:customer_profile_id => self.customer_profile_id, :address => self.shipping_profiles.last.shipping_address )
      if @response.success?
          self.shipping_profiles.last.update_attribute('customer_address_id', @response.params["customer_address_id"])
      end   
      return @response     
  end      
  
end
