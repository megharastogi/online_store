class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price ,:precision=>8 ,:scale => 2, :default => 0
      t.integer :quantity ,:default => 0
      t.boolean :is_featured ,:default => false
      t.boolean :visible ,:default => true
      t.string :dimension
      t.integer :weight,:precision=>8 ,:scale => 2, :default => 0
      t.string :sku
      t.integer :category_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
