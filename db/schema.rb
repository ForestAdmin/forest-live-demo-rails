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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180403164445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "address_line_1", null: false
    t.string "address_line_2"
    t.string "address_city", null: false
    t.string "country", null: false
    t.integer "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "reason"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status"
  end

  create_table "companies", id: :integer, default: -> { "nextval('\"Companies_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "industry"
    t.string "headquarter"
    t.string "status"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid "certificate_of_incorporation_id"
    t.uuid "proof_of_address_id"
    t.uuid "bank_statement_id"
    t.uuid "passport_id"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "stripe_id"
    t.string "avatar"
    t.date "birth_date"
  end

  create_table "deliveries", id: :serial, force: :cascade do |t|
    t.string "phone"
    t.float "lng"
    t.float "lat"
    t.boolean "is_delivered"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", id: :serial, force: :cascade do |t|
    t.string "file_id", null: false
    t.boolean "is_verified", null: false
  end

  create_table "orders", primary_key: "ref", id: :string, default: -> { "nextval('orders_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "shipping_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "product_id"
    t.integer "customer_id"
    t.datetime "being_processed_at"
    t.integer "delivery_id"
    t.datetime "ready_for_shipping_at"
    t.datetime "in_transit_at"
    t.datetime "shipped_at"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "price"
    t.text "label"
    t.string "picture"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.string "beneficiary_iban", null: false
    t.string "emitter_iban", null: false
    t.integer "vat_amount"
    t.integer "amount", null: false
    t.integer "fee_amount"
    t.text "note"
    t.string "emitter_bic", null: false
    t.string "beneficiary_bic", null: false
    t.string "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "beneficiary_company_id"
    t.integer "emitter_company_id"
    t.string "status"
  end

  add_foreign_key "addresses", "customers", name: "addresses_company_id_fkey"
  add_foreign_key "orders", "customers", name: "orders_customer_id_fkey"
  add_foreign_key "orders", "deliveries", name: "orders_delivery_id_fkey"
  add_foreign_key "orders", "products", name: "orders_product_id_fkey"
  add_foreign_key "transactions", "companies", column: "beneficiary_company_id", name: "transactions_beneficiary_company_id_fkey"
  add_foreign_key "transactions", "companies", column: "emitter_company_id", name: "transactions_emitter_company_id_fkey"
end
