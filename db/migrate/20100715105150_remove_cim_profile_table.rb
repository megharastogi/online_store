class RemoveCimProfileTable < ActiveRecord::Migration
  def self.up
     drop_table :cim_profiles
  end

  def self.down
      create_table :cim_profiles do |t|

        t.timestamps
      end
  end
end
