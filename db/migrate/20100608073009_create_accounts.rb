class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table "accounts", :force => true do |t|
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :resource_type,             :string
      t.column :resource_id,               :integer
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime


    end
    add_index :accounts, :email, :unique => true
  end

  def self.down
    drop_table "accounts"
  end
end
