class Admin < ActiveRecord::Base
  has_one :account, :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :account
  
  validates_presence_of :role
end
