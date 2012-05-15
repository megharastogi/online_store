class ShippingProfile < ActiveRecord::Base
    
    belongs_to :user

    validates_presence_of :shipping_first_name,:shipping_last_name, :shipping_street_address, :shipping_city, :shipping_state, :shipping_country, 
      :shipping_zip
    
    def shipping_address
        {
            :first_name   =>  shipping_first_name,
            :last_name    =>  shipping_last_name,
            :address      =>  shipping_street_address, 
            :city         =>  shipping_city,
            :state        =>  shipping_state, 
            :zip_code     =>  shipping_zip,
            :country      =>  shipping_country
        }
    end

end
