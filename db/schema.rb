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

ActiveRecord::Schema.define(version: 20140830044423) do

  create_table "builds", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repository_id"
    t.integer  "commit_id"
    t.string   "number"
    t.integer  "pull_request_id"
    t.string   "state"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "duration"
  end

  add_index "builds", ["pull_request_id"], name: "index_builds_on_pull_request_id"
  add_index "builds", ["repository_id", "number"], name: "index_builds_on_repository_id_and_number"

  create_table "jobs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "build_id"
    t.integer  "log_id"
    t.string   "number"
    t.string   "state"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "duration"
    t.string   "queue"
    t.string   "rvm"
    t.string   "env"
  end

  add_index "jobs", ["build_id", "number"], name: "index_jobs_on_build_id_and_number"

  create_table "pull_requests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
    t.string   "title"
  end

  create_table "repositories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "private"
    t.text     "description"
    t.string   "github_language"
  end

  add_index "repositories", ["slug"], name: "index_repositories_on_slug"

end
