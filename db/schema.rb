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

ActiveRecord::Schema.define(version: 20150926181727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.integer  "serie_id"
    t.integer  "number"
    t.integer  "season"
    t.date     "air_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "episodes", ["serie_id"], name: "index_episodes_on_serie_id", using: :btree

  create_table "series", force: :cascade do |t|
    t.string   "title"
    t.string   "picture_url"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "show_id"
    t.integer  "number_of_seasons"
    t.integer  "last_episode_watched_id"
  end

  add_index "series", ["show_id"], name: "index_series_on_show_id", unique: true, using: :btree

end
