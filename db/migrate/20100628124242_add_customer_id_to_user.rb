class AddCustomerIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :customer_profile_id , :string
  end

  def self.down
    remove_column :users , :customer_profile_id
  end
end
