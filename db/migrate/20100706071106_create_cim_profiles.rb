class CreateCimProfiles < ActiveRecord::Migration
  def self.up
    create_table :cim_profiles do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :cim_profiles
  end
end
