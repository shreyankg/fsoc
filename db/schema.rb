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

ActiveRecord::Schema.define(:version => 20100512095415) do

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "definition"
    t.integer  "eta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      :default => "proposed"
    t.integer  "proposer_id"
    t.integer  "mentor_id"
    t.string   "urls"
  end

  create_table "proposals", :force => true do |t|
    t.integer  "project_id"
    t.integer  "student_id"
    t.text     "proposal_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted",      :default => false
  end

  create_table "tasks", :force => true do |t|
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.date     "end_date"
    t.date     "start_date"
    t.string   "title"
    t.integer  "eta"
    t.integer  "proposal_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "user_type",                                :default => "student"
    t.string   "webpage"
    t.string   "irc_nick"
    t.string   "irc_channels"
    t.string   "org"
    t.text     "bio"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
