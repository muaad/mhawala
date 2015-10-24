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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151024113244) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "active",     default: false
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "agents", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "city"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "account_id"
    t.boolean  "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "agents", ["account_id"], name: "index_agents_on_account_id"

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "country"
    t.string   "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "currency_one"
    t.string   "currency_two"
    t.float    "buying"
    t.float    "selling"
    t.string   "city"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "exchange_rates", ["account_id"], name: "index_exchange_rates_on_account_id"

  create_table "payments", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.float    "amount"
    t.string   "reference_number"
    t.string   "transaction_number"
    t.integer  "account_id"
    t.boolean  "sent",               default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "channel",            default: "Hawala"
    t.boolean  "withdrawn",          default: false
    t.integer  "recorded_by_id"
    t.integer  "withdrawn_by_id"
    t.datetime "withdrawn_at"
    t.string   "sent_from"
    t.string   "sent_to"
    t.integer  "from_agent_id"
    t.integer  "to_agent_id"
  end

  add_index "payments", ["account_id"], name: "index_payments_on_account_id"
  add_index "payments", ["from_agent_id"], name: "index_payments_on_from_agent_id"
  add_index "payments", ["recipient_id"], name: "index_payments_on_recipient_id"
  add_index "payments", ["recorded_by_id"], name: "index_payments_on_recorded_by_id"
  add_index "payments", ["sender_id"], name: "index_payments_on_sender_id"
  add_index "payments", ["to_agent_id"], name: "index_payments_on_to_agent_id"
  add_index "payments", ["withdrawn_by_id"], name: "index_payments_on_withdrawn_by_id"

  create_table "user_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.boolean  "is_preferred", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "user_accounts", ["account_id"], name: "index_user_accounts_on_account_id"
  add_index "user_accounts", ["user_id"], name: "index_user_accounts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.string   "phone_number"
    t.boolean  "is_admin",                 default: false
    t.boolean  "is_support",               default: false
    t.string   "user_type"
    t.integer  "agent_id"
  end

  add_index "users", ["agent_id"], name: "index_users_on_agent_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
