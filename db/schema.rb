# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_27_011726) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "late", default: false
    t.integer "state"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "branch_opening_time"
    t.time "branch_closing_time"
    t.time "stamp"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "opens_at"
    t.time "close_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string "discountable_type"
    t.bigint "discountable_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "PHP", null: false
    t.float "percent"
    t.integer "off_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discountable_type", "discountable_id"], name: "index_discounts_on_discountable"
  end

  create_table "notes", force: :cascade do |t|
    t.string "message"
    t.bigint "user_id"
    t.string "notable_type"
    t.bigint "notable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "status"
    t.integer "quantity", default: 0
    t.integer "subtotal_cents", default: 0, null: false
    t.string "subtotal_currency", default: "PHP", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "PHP", null: false
    t.bigint "order_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "purchasing_price_cents", default: 0, null: false
    t.string "purchasing_price_currency", default: "PHP", null: false
    t.string "type"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status"
    t.string "order_number"
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "PHP", null: false
    t.integer "subtotal_cents", default: 0, null: false
    t.string "subtotal_currency", default: "PHP", null: false
    t.datetime "completed_at"
    t.bigint "branch_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remarks"
    t.index ["branch_id"], name: "index_orders_on_branch_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "amount_paid_cents", default: 0, null: false
    t.string "amount_paid_currency", default: "PHP", null: false
    t.integer "change_cents", default: 0, null: false
    t.string "change_currency", default: "PHP", null: false
    t.integer "status"
    t.string "transaction_id"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remarks"
    t.integer "payment_method"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "product_items", force: :cascade do |t|
    t.bigint "order_item_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_id"], name: "index_product_items_on_order_item_id"
    t.index ["product_id"], name: "index_product_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "PHP", null: false
    t.integer "cost_cents", default: 0, null: false
    t.string "cost_currency", default: "PHP", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "branch_id"
    t.integer "status"
    t.integer "quantity", default: 0
    t.datetime "deleted_at"
    t.string "type"
    t.index ["branch_id"], name: "index_products_on_branch_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "account_number"
    t.string "address"
    t.bigint "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role"
    t.integer "status"
    t.index ["branch_id"], name: "index_users_on_branch_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "wallet_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "PHP", null: false
    t.integer "status"
    t.string "type"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallet_transactions_on_user_id"
    t.index ["wallet_id"], name: "index_wallet_transactions_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "branch_id"
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "PHP", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_wallets_on_branch_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "notes", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "payments", "orders"
  add_foreign_key "wallet_transactions", "users"
  add_foreign_key "wallet_transactions", "wallets"
  add_foreign_key "wallets", "branches"
end
