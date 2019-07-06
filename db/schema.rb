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

ActiveRecord::Schema.define(version: 2019_06_29_064841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "company_name", null: false
    t.string "company_name_kana", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "locales", force: :cascade do |t|
    t.string "locale_name", limit: 191, null: false
    t.integer "admin_id", null: false
    t.string "control_number", limit: 191, null: false
    t.string "password_digest", limit: 191, null: false
    t.string "remember_token", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_locales_on_admin_id"
    t.index ["control_number"], name: "index_locales_on_control_number"
    t.index ["locale_name"], name: "index_locales_on_locale_name"
  end

  create_table "managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "family_name", null: false
    t.string "family_name_kana", null: false
    t.string "given_name", null: false
    t.string "given_name_kana", null: false
    t.integer "locale_id", null: false
    t.integer "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_managers_on_admin_id"
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["family_name"], name: "index_managers_on_family_name"
    t.index ["family_name_kana"], name: "index_managers_on_family_name_kana"
    t.index ["given_name"], name: "index_managers_on_given_name"
    t.index ["given_name_kana"], name: "index_managers_on_given_name_kana"
    t.index ["locale_id"], name: "index_managers_on_locale_id"
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "staffs", force: :cascade do |t|
    t.string "family_name", null: false
    t.string "family_name_kana", null: false
    t.string "given_name", null: false
    t.string "given_name_kana", null: false
    t.integer "locale_id", null: false
    t.integer "admin_id", null: false
    t.text "qrcode"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_name"], name: "index_staffs_on_family_name"
    t.index ["family_name_kana"], name: "index_staffs_on_family_name_kana"
    t.index ["given_name"], name: "index_staffs_on_given_name"
    t.index ["given_name_kana"], name: "index_staffs_on_given_name_kana"
    t.index ["locale_id"], name: "index_staffs_on_locale_id"
  end

end
