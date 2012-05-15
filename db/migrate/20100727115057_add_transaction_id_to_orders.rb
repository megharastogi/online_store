class AddTransactionIdToOrders < ActiveRecord::Migration
  def self.up
      add_column :orders, :transaction_id , :string
  end

  def self.down
      remove_column :orders , :transaction_id
  end
end
