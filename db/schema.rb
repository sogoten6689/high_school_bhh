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

ActiveRecord::Schema.define(version: 2022_06_05_152054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "type_name"
    t.string "name_with_type"
    t.string "path"
    t.string "path_with_type"
    t.integer "code"
    t.integer "parent_code"
    t.integer "change_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ethnicities", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.string "ethnicity_slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "type_name"
    t.string "name_with_type"
    t.integer "code"
    t.integer "change_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.string "father_name"
    t.integer "father_year"
    t.string "father_career"
    t.string "father_phone"
    t.string "father_address"
    t.string "mother_name"
    t.integer "mother_year"
    t.string "mother_career"
    t.string "mother_phone"
    t.string "mother_address"
    t.string "guardian_name"
    t.integer "guardian_year"
    t.string "guardian_career"
    t.string "guardian_phone"
    t.string "guardian_address"
    t.string "vietschool_connect_phone"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "difficult_area"
    t.string "difficult_code"
    t.integer "revolutionary_family", default: 0
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "student_classes", force: :cascade do |t|
    t.string "class_name"
    t.integer "student_class_code"
    t.integer "grade"
    t.integer "year"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_student_classes_on_user_id"
  end

  create_table "user_contacts", force: :cascade do |t|
    t.integer "household_province"
    t.integer "household_district"
    t.integer "household_ward"
    t.string "household_address"
    t.integer "contact_province"
    t.integer "contact_district"
    t.integer "contact_ward"
    t.string "contact_address"
    t.string "phone_number"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_contacts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "name"
    t.integer "gender"
    t.date "birthday"
    t.integer "province"
    t.integer "ethnicity"
    t.string "another_ethnicity"
    t.string "identification"
    t.string "identification_image"
    t.string "student_code"
    t.integer "role", default: 0
    t.integer "religion"
    t.string "another_religion"
    t.integer "identification_type"
    t.string "identifier_code"
    t.integer "identification_chip", default: 0
    t.string "health_insurance_code"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "wards", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "type_name"
    t.string "name_with_type"
    t.string "path"
    t.string "path_with_type"
    t.integer "code"
    t.integer "parent_code"
    t.integer "change_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "relationships", "users"
  add_foreign_key "student_classes", "users"
  add_foreign_key "user_contacts", "users"
end
