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

ActiveRecord::Schema.define(version: 20140926034131) do

  create_table "charts", force: true do |t|
    t.string   "title"
    t.string   "creator"
    t.text     "description"
    t.string   "chart_type"
    t.string   "database"
    t.text     "sql_query"
    t.string   "x_column"
    t.string   "y_column"
    t.string   "grouping_column"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_games", id: false, force: true do |t|
    t.integer "game_id"
    t.date    "game_date",                                  null: false
    t.integer "home_team_id",                               null: false
    t.integer "away_team_id",                               null: false
    t.integer "neutral_site",                               null: false
    t.string  "ncaa_game_link",             default: ""
    t.boolean "crawled",                    default: false, null: false
    t.string  "location",       limit: 100
    t.integer "attendance"
    t.string  "officials"
  end

  add_index "d_games", ["game_id"], name: "game_id", using: :btree

  create_table "d_players", id: false, force: true do |t|
    t.integer "player_id",              null: false
    t.integer "team_id",                null: false
    t.integer "year",                   null: false
    t.string  "player_name", limit: 50
    t.integer "jersey"
    t.string  "player_year", limit: 10
  end

  create_table "d_team", primary_key: "team_id", force: true do |t|
    t.string "team_name", limit: 30, default: "", null: false
  end

  create_table "d_team_year", id: false, force: true do |t|
    t.integer "team_id",                    null: false
    t.integer "year",                       null: false
    t.integer "year_code",                  null: false
    t.string  "team_year_url", default: "", null: false
  end

  create_table "f_event_stats", primary_key: "event_id", force: true do |t|
    t.integer "game_id",                                      null: false
    t.string  "event_type",          limit: 20,  default: "", null: false
    t.integer "event_time",                                   null: false
    t.string  "event_description",   limit: 200
    t.integer "player_id"
    t.integer "team_id",                                      null: false
    t.integer "possession_id"
    t.integer "quarter"
    t.integer "associated_event_id"
  end

  add_index "f_event_stats", ["game_id"], name: "game_id", using: :btree
  add_index "f_event_stats", ["team_id"], name: "team_id", using: :btree

  create_table "f_player_stats", id: false, force: true do |t|
    t.integer "player_id",                              null: false
    t.integer "team_id",                                null: false
    t.integer "game_id",                                null: false
    t.string  "position",       limit: 11, default: ""
    t.integer "goals"
    t.integer "assists"
    t.integer "points"
    t.integer "shots"
    t.integer "sog"
    t.integer "man_up_goals"
    t.integer "man_down_goals"
    t.integer "gb"
    t.integer "to"
    t.integer "ct"
    t.integer "fo_won"
    t.integer "fo_taken"
    t.integer "pen"
    t.integer "pen_time"
    t.string  "g_min",          limit: 11
    t.integer "g_allowed"
    t.integer "g_saved"
  end

  create_table "foo", force: true do |t|
    t.string   "title"
    t.string   "creator"
    t.text     "description"
    t.string   "chart_type"
    t.string   "database"
    t.text     "sql_query"
    t.string   "x_column"
    t.string   "y_column"
    t.string   "grouping_column"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
