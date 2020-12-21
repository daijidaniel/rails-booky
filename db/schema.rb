# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_21_210007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "additional_items", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "item_id"
    t.integer "quantity"
    t.integer "total_price"
    t.index ["booking_id"], name: "index_additional_items_on_booking_id"
  end

  create_table "additional_variants", force: :cascade do |t|
    t.bigint "variant_id"
    t.bigint "booking_id"
    t.integer "quantity", default: 0
    t.index ["booking_id"], name: "index_additional_variants_on_booking_id"
    t.index ["variant_id"], name: "index_additional_variants_on_variant_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "country"
    t.string "postcode"
    t.string "phone"
    t.string "vat_id"
    t.index ["user_id"], name: "index_addresses_on_user_id", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "amount"
    t.integer "payment_status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.integer "adult_capacity"
    t.integer "child_capacity", default: 0
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "PLN", null: false
    t.bigint "payment_id"
    t.index ["payment_id"], name: "index_bookings_on_payment_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "PLN", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "payu_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "unit_bookings", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "booking_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "capacity"
    t.string "slug"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "PLN", null: false
    t.index ["slug"], name: "index_units_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fname"
    t.string "lname"
    t.integer "auth_level", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "item_id"
    t.string "name"
    t.string "description"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "PLN", null: false
    t.index ["item_id"], name: "index_variants_on_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "bookings", "payments"
  add_foreign_key "bookings", "users"
  add_foreign_key "unit_bookings", "bookings"
  add_foreign_key "unit_bookings", "units"
end
