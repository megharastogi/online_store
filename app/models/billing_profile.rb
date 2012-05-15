class BillingProfile < ActiveRecord::Base
    
    belongs_to :user
    
    attr_accessor :credit_card_number, :month, :year, :name_on_card, :card_type, :card_verification_value
                  # :shipping_first_name,:shipping_last_name, :shipping_street_address, :shipping_city, :shipping_state, :shipping_country, 
                  #              :shipping_zip_code
        
    validates_presence_of :credit_card_number, :month, :year, :name_on_card, :card_type, :card_verification_value, :billing_first_name,:billing_last_name, :billing_street_address, :billing_city, :billing_state, :billing_country, :billing_zip
    validates_length_of :credit_card_number , :minimum => 16


    def credit_card
           @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
             :type               => card_type,
             :number             => credit_card_number,
             :verification_value => card_verification_value,
             :month              => month,
             :year               => year,
             :first_name         => billing_first_name,
             :last_name          => billing_last_name
           )
         end

         def payment_profiles
            {
                :bill_to => billing_address,
                :payment => payment
            }
         end     

         def billing_address
             {
                 :first_name   =>  billing_first_name,
                 :last_name    =>  billing_last_name,
                 :address      =>  billing_street_address,
                 :city         =>  billing_city,
                 :state        =>  billing_state,
                 :country      =>  billing_country,
                 :zip          =>  billing_zip
             }
         end
         
        
         # Payment hash for making authorizecim.net request
         def payment
             {
                 :credit_card => credit_card
             }
         end
    
                          
end
