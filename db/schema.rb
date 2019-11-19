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

ActiveRecord::Schema.define(version: 20191111075014) do

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "drafts", force: :cascade do |t|
    t.integer  "proposal_id", null: false
    t.integer  "version",     null: false
    t.datetime "written_at",  null: false
    t.string   "state",       null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "external_links", force: :cascade do |t|
    t.integer  "draft_id",   null: false
    t.string   "title",      null: false
    t.boolean  "current",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.string   "title",                            null: false
    t.text     "body",                             null: false
    t.boolean  "reviewed",         default: false, null: false
    t.integer  "author_id",                        null: false
    t.integer  "current_draft_id"
    t.integer  "current_draft"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
