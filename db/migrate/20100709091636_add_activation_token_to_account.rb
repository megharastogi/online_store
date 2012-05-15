class AddActivationTokenToAccount < ActiveRecord::Migration
  def self.up
      add_column :accounts, :activation_token , :string
  end

  def self.down
      remove_column :accounts , :activation_token
  end
end
