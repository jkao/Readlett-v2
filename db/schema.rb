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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120306074046) do

  create_table "authorizations", :force => true do |t|
    t.string  "provider", :null => false
    t.string  "uid",      :null => false
    t.integer "user_id",  :null => false
  end

  create_table "bookmarks", :force => true do |t|
    t.string   "title",       :limit => 64,                    :null => false
    t.string   "description"
    t.string   "link",                                         :null => false
    t.integer  "user_id",                                      :null => false
    t.boolean  "private",                   :default => false, :null => false
    t.boolean  "nsfw",                      :default => false, :null => false
    t.string   "disqus_uuid"
    t.integer  "views"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "bookmarks_tags", :force => true do |t|
    t.integer "bookmark_id", :null => false
    t.integer "tag_id",      :null => false
  end

  create_table "bookmarks_users", :force => true do |t|
    t.integer  "bookmark_id",                    :null => false
    t.integer  "user_id",                        :null => false
    t.string   "current_url",                    :null => false
    t.boolean  "finished",    :default => false, :null => false
    t.boolean  "private",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "featured_items", :force => true do |t|
    t.integer  "bookmark_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "start",       :null => false
    t.datetime "end",         :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pictures_users", :force => true do |t|
    t.string   "picture",                       :null => false
    t.string   "uuid",                          :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "bookmark_id", :null => false
    t.integer  "user_id",     :null => false
    t.integer  "rating",      :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reports", :force => true do |t|
    t.integer "complaint_bookmark_id"
    t.integer "complaint_user_id"
    t.integer "complainer_user_id"
    t.string  "reason"
  end

  create_table "tags", :force => true do |t|
    t.string "code", :null => false
    t.string "name", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",       :limit => 64, :null => false
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.string   "disqus_uuid"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
