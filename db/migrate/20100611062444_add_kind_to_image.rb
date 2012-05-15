class AddKindToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :kind, :string
  end

  def self.down
    remove_column :images, :kind
  end
end
