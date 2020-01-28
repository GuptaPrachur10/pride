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

ActiveRecord::Schema.define(version: 2020_01_22_104044) do

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile"
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_drivers_on_email", unique: true
    t.index ["mobile"], name: "index_drivers_on_mobile", unique: true
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "rider_id"
    t.integer "driver_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_relationships_on_driver_id"
    t.index ["rider_id", "driver_id"], name: "index_relationships_on_rider_id_and_driver_id", unique: true
    t.index ["rider_id"], name: "index_relationships_on_rider_id"
  end

  create_table "riders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_riders_on_email", unique: true
    t.index ["mobile"], name: "index_riders_on_mobile", unique: true
  end

  create_table "rides", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.datetime "date"
    t.integer "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
    t.string "from_city"
    t.string "to_city"
    t.float "distance"
    t.index ["driver_id"], name: "index_rides_on_driver_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.datetime "date"
    t.integer "rider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from_city"
    t.string "to_city"
    t.float "distance"
    t.index ["rider_id"], name: "index_routes_on_rider_id"
  end

end
