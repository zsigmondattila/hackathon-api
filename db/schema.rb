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

ActiveRecord::Schema[7.1].define(version: 2024_03_22_141413) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "point_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collect_points", force: :cascade do |t|
    t.string "type"
    t.string "address"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "contact_phone"
    t.bigint "partner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_collect_points_on_partner_id"
  end

  create_table "devise_api_tokens", force: :cascade do |t|
    t.string "resource_owner_type", null: false
    t.bigint "resource_owner_id", null: false
    t.string "access_token", null: false
    t.string "refresh_token"
    t.integer "expires_in", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token"], name: "index_devise_api_tokens_on_access_token"
    t.index ["previous_refresh_token"], name: "index_devise_api_tokens_on_previous_refresh_token"
    t.index ["refresh_token"], name: "index_devise_api_tokens_on_refresh_token"
    t.index ["resource_owner_type", "resource_owner_id"], name: "index_devise_api_tokens_on_resource_owner"
  end

  create_table "earned_achievements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "achievement_id", null: false
    t.date "earn_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_earned_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_earned_achievements_on_user_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scoreboards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "points"
    t.date "points_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scoreboards_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "voucher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
    t.index ["voucher_id"], name: "index_transactions_on_voucher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "provider"
    t.string "phone_number"
    t.decimal "balance"
    t.integer "leaderboard_position"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vouchers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "value"
    t.date "valability"
    t.string "barcode"
    t.boolean "is_valid"
    t.bigint "partner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_vouchers_on_partner_id"
    t.index ["user_id"], name: "index_vouchers_on_user_id"
  end

  add_foreign_key "collect_points", "partners"
  add_foreign_key "earned_achievements", "achievements"
  add_foreign_key "earned_achievements", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "scoreboards", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "vouchers"
  add_foreign_key "vouchers", "partners"
  add_foreign_key "vouchers", "users"
end
