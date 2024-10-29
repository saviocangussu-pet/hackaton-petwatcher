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

ActiveRecord::Schema[7.1].define(version: 2024_10_29_185141) do
  create_table "locations", force: :cascade do |t|
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.boolean "owner", default: false
    t.boolean "sitter", default: false
    t.integer "location_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["location_id"], name: "index_people_on_location_id"
    t.index ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true
  end

  create_table "people_species", force: :cascade do |t|
    t.integer "people_id"
    t.integer "specie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["people_id"], name: "index_people_species_on_people_id"
    t.index ["specie_id"], name: "index_people_species_on_specie_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "specie_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_pets_on_owner_id"
    t.index ["specie_id"], name: "index_pets_on_specie_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "reviewable_type"
    t.integer "reviewable_id"
    t.integer "stars"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pets", "owners"
end
