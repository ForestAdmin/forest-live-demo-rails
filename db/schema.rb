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

ActiveRecord::Schema.define(version: 2019_02_05_110731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address_line1"
    t.string "address_line2"
    t.string "address_city"
    t.string "country"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "postcode"
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.string "name"
    t.text "reason"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :bigint, default: -> { "nextval('\"Companies_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.string "headquarter"
    t.string "status"
    t.text "description"
    t.uuid "certificate_of_incorporation_id"
    t.uuid "proof_of_address_id"
    t.uuid "bank_statement_id"
    t.uuid "passport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.date "birth_date"
    t.boolean "active", default: false, null: false
    t.text "gender", default: [], array: true
    t.bigint "patient_status_id"
    t.index ["patient_status_id"], name: "index_customers_on_patient_status_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.decimal "lng"
    t.decimal "lat"
    t.boolean "is_delivered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "file_id"
    t.boolean "is_verified"
  end

  create_table "orders", primary_key: "ref", id: :string, default: -> { "nextval('orders_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "shipping_status"
    t.datetime "being_processed_at"
    t.datetime "ready_for_shipping_at"
    t.datetime "in_transit_at"
    t.datetime "shipped_at"
    t.bigint "product_id"
    t.bigint "customer_id"
    t.bigint "delivery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["delivery_id"], name: "index_orders_on_delivery_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "patient_statuses", force: :cascade do |t|
    t.integer "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.decimal "price"
    t.text "label"
    t.text "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "iPhone"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "beneficiary_iban"
    t.string "emitter_iban"
    t.integer "vat_amount"
    t.integer "amount"
    t.integer "fee_amount"
    t.text "note"
    t.string "emitter_bic"
    t.string "beneficiary_bic"
    t.string "reference"
    t.string "status"
    t.bigint "beneficiary_company_id"
    t.bigint "emitter_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beneficiary_company_id"], name: "index_transactions_on_beneficiary_company_id"
    t.index ["emitter_company_id"], name: "index_transactions_on_emitter_company_id"
  end

  create_table "treatment_tasks", force: :cascade do |t|
    t.string "label"
    t.boolean "is_done"
    t.bigint "treatment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["treatment_id"], name: "index_treatment_tasks_on_treatment_id"
  end

  create_table "treatments", force: :cascade do |t|
    t.string "overview"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_treatments_on_customer_id"
  end

  add_foreign_key "addresses", "customers", name: "addresses_company_id_fkey"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "customers", name: "orders_customer_id_fkey"
  add_foreign_key "orders", "deliveries"
  add_foreign_key "orders", "deliveries", name: "orders_delivery_id_fkey"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "products", name: "orders_product_id_fkey"
  add_foreign_key "transactions", "companies", column: "beneficiary_company_id"
  add_foreign_key "transactions", "companies", column: "beneficiary_company_id", name: "transactions_beneficiary_company_id_fkey"
  add_foreign_key "transactions", "companies", column: "emitter_company_id"
  add_foreign_key "transactions", "companies", column: "emitter_company_id", name: "transactions_emitter_company_id_fkey"
  add_foreign_key "treatment_tasks", "treatments"
end
