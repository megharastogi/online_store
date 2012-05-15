class CreateBillingProfiles < ActiveRecord::Migration
  def self.up
    create_table :billing_profiles do |t|
      t.column :user_id , :integer    
      t.column :customer_payment_profile_id ,:string
      t.column :billing_first_name , :string    
      t.column :billing_last_name , :string    
      t.column :billing_street_address , :string    
      t.column :billing_city , :string    
      t.column :billing_state , :string    
      t.column :billing_country , :string    
      t.column :billing_zip ,:string    
      t.timestamps
    end
  end

  def self.down
    drop_table :billing_profiles
  end
end
