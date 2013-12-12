# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131212185010) do

  create_table "customers", :force => true do |t|
    t.string   "first_name",          :null => false
    t.string   "last_name",           :null => false
    t.string   "email_address",       :null => false
    t.string   "address_street",      :null => false
    t.string   "address_city",        :null => false
    t.string   "address_postal_code", :null => false
    t.string   "address_country",     :null => false
    t.string   "phone_number",        :null => false
    t.text     "notes"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "address_state"
  end

  create_table "order_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "order_products", ["order_id"], :name => "index_order_products_on_order_id"
  add_index "order_products", ["product_id"], :name => "index_order_products_on_product_id"

  create_table "orders", :force => true do |t|
    t.integer  "customer_id",                                                                   :null => false
    t.string   "payment_status",                                   :default => "Unpaid",        :null => false
    t.string   "fulfillment_status",                               :default => "Not Fulfilled", :null => false
    t.datetime "created_at",                                                                    :null => false
    t.datetime "updated_at",                                                                    :null => false
    t.decimal  "price",              :precision => 8, :scale => 2
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"

  create_table "products", :force => true do |t|
    t.string   "title",                                                       :null => false
    t.text     "description",                                                 :null => false
    t.string   "vendor"
    t.decimal  "price",       :precision => 8, :scale => 2,                   :null => false
    t.string   "sku"
    t.string   "barcode"
    t.boolean  "visible",                                   :default => true
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.string   "category"
  end

  create_table "profiles", :force => true do |t|
    t.string   "store_name"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "address_street"
    t.string   "address_country"
    t.string   "address_state"
    t.string   "address_postal_code"
  end

  create_table "sessions", :force => true do |t|
    t.integer  "store_id"
    t.string   "token"
    t.string   "ip_address"
    t.string   "user_agent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["store_id"], :name => "index_sessions_on_store_id"
  add_index "sessions", ["token"], :name => "index_sessions_on_token"

  create_table "stores", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "password_digest", :null => false
    t.string   "email",           :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "stores", ["email"], :name => "index_stores_on_email", :unique => true
  add_index "stores", ["name"], :name => "index_stores_on_name", :unique => true

end
