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

ActiveRecord::Schema.define(version: 20150917043749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "algorithms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "transportation"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "trip_id"
  end

  add_index "events", ["trip_id"], name: "index_events_on_trip_id", using: :btree

  create_table "gps_data", force: :cascade do |t|
    t.datetime "time"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "altitude"
    t.string   "accuracy"
    t.string   "speed"
    t.string   "bearing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "intermediatepoints", force: :cascade do |t|
    t.datetime "time"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "altitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "trip_id"
  end

  add_index "intermediatepoints", ["trip_id"], name: "index_intermediatepoints_on_trip_id", using: :btree

  create_table "transfer_zones", force: :cascade do |t|
    t.datetime "time"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "altitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
  end

  add_index "transfer_zones", ["event_id"], name: "index_transfer_zones_on_event_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.string   "avgSpeed"
    t.string   "duration"
    t.string   "distance"
    t.boolean  "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "password"
    t.string   "bithday"
    t.string   "address"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "events", "trips"
  add_foreign_key "intermediatepoints", "trips"
  add_foreign_key "transfer_zones", "events"
  add_foreign_key "trips", "users"
end
