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

ActiveRecord::Schema.define(:version => 20081129140251) do

  create_table "anketas", :force => true do |t|
    t.string   "title",                       :null => false
    t.integer  "status_id",    :default => 0, :null => false
    t.datetime "published_at"
    t.text     "description"
    t.integer  "key_word"
    t.integer  "mark_total"
    t.integer  "votes_total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "anketas_questions", :id => false, :force => true do |t|
    t.integer "question_id", :null => false
    t.integer "anketa_id",   :null => false
  end

  add_index "anketas_questions", ["question_id"], :name => "fk_bk_questions"
  add_index "anketas_questions", ["anketa_id"], :name => "fk_bk_polls"

  create_table "hodnocenis", :force => true do |t|
    t.integer  "znamka"
    t.integer  "user_id"
    t.string   "user_body"
    t.integer  "anketa_id"
    t.integer  "question_id"
    t.integer  "session_id"
    t.string   "podpis"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "position"
    t.string   "question"
    t.string   "answer"
    t.boolean  "yes"
    t.integer  "mark_total"
    t.integer  "votes_total"
    t.string   "first_name"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "statuses", :force => true do |t|
    t.string "name", :null => false
  end

end
