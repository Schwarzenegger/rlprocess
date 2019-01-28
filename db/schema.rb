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

ActiveRecord::Schema.define(version: 2019_01_24_113559) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activity_profiles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_profiles_master_activities", id: false, force: :cascade do |t|
    t.bigint "activity_profile_id", null: false
    t.bigint "master_activity_id", null: false
    t.index ["activity_profile_id", "master_activity_id"], name: "activity_and_profiles_index"
  end

  create_table "clients", force: :cascade do |t|
    t.string "cnpj"
    t.string "social_name"
    t.string "municipal_inscription"
    t.string "state_inscription"
    t.date "date_of_founding"
    t.integer "taxation"
    t.string "contact"
    t.string "email"
    t.string "telephone"
    t.string "iss_password"
    t.string "simples_password"
    t.date "start_accounting"
    t.date "end_accounting"
    t.float "honorary"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.string "partner_name"
    t.string "partner_cpf"
  end

  create_table "master_activities", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.integer "frequency"
    t.string "deadline_month", array: true
    t.integer "deadline_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline_date"
  end

  create_table "master_checklist_options", force: :cascade do |t|
    t.string "name"
    t.bigint "master_activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["master_activity_id"], name: "index_master_checklist_options_on_master_activity_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "role"
    t.float "salary"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
