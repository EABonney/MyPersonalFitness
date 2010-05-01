# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100418141555) do

  create_table "notifiers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "race_types", :force => true do |t|
    t.string "race_type"
    t.string "race_distance"
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.string   "race_type"
    t.string   "race_distance"
    t.float    "swim_distance", :default => 0.0
    t.float    "bike_distance", :default => 0.0
    t.float    "run_distance",  :default => 0.0
    t.date     "race_date"
    t.time     "race_time"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_points", :force => true do |t|
    t.decimal  "lat",        :precision => 15, :scale => 10
    t.decimal  "lng",        :precision => 15, :scale => 10
    t.integer  "route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "routes", :force => true do |t|
    t.string   "name"
    t.float    "distance_mi"
    t.float    "distance_km"
    t.string   "route_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username",                               :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "active",              :default => false, :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
  end

  create_table "workouts", :force => true do |t|
    t.date     "workout_date"
    t.time     "time_of_day"
    t.time     "duration"
    t.float    "distance"
    t.integer  "user_id"
    t.string   "type"
    t.text     "notes"
    t.string   "plan_type"
    t.integer  "min_hr",       :default => 0
    t.integer  "avg_hr",       :default => 0
    t.integer  "max_hr",       :default => 0
    t.integer  "cals_burned",  :default => 0
    t.float    "pace"
    t.float    "avg_rpms",     :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_id"
    t.string   "description"
  end

end
