class CreateShippingProfiles < ActiveRecord::Migration
  def self.up
    create_table :shipping_profiles do |t|
      t.column :user_id , :integer    
      t.column :customer_address_id ,:string
      t.column :shipping_first_name , :string    
      t.column :shipping_last_name , :string    
      t.column :shipping_street_address , :string    
      t.column :shipping_city , :string    
      t.column :shipping_state , :string    
      t.column :shipping_country , :string    
      t.column :shipping_zip ,:string
      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_profiles
  end
end
