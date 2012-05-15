class AddResetTokenToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :reset_token, :string
  end

  def self.down
    remove_column :accounts , :reset_token
  end
end
