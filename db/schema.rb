# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100727115057) do

  create_table "accounts", :force => true do |t|
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "reset_token"
    t.string   "activation_token"
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email", :unique => true

  create_table "admins", :force => true do |t|
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "customer_payment_profile_id"
    t.string   "billing_first_name"
    t.string   "billing_last_name"
    t.string   "billing_street_address"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_country"
    t.string   "billing_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "record_id"
    t.string   "record_type"
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind"
  end

  create_table "items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transaction_id"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       :precision => 8, :scale => 2, :default => 0.0
    t.integer  "quantity",                                  :default => 0
    t.boolean  "is_featured",                               :default => false
    t.boolean  "visible",                                   :default => true
    t.string   "dimension"
    t.integer  "weight",                                    :default => 0
    t.string   "sku"
    t.integer  "category_id",                                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shipping_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "customer_address_id"
    t.string   "shipping_first_name"
    t.string   "shipping_last_name"
    t.string   "shipping_street_address"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_country"
    t.string   "shipping_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_profile_id"
  end

end
