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

ActiveRecord::Schema.define(:version => 20120104014913) do

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "points_up"
    t.integer  "points_down"
    t.decimal  "confidence_value"
    t.decimal  "relative_value"
    t.decimal  "karma"
    t.integer  "time_effective"
    t.boolean  "is_anonymous"
    t.string   "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "is_saged"
  end

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "session_hash"
    t.string   "ip_address"
    t.string   "message"
    t.string   "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "linked_accounts", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "service"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "linked_accounts", ["email"], :name => "index_linked_accounts_on_email", :unique => true
  add_index "linked_accounts", ["reset_password_token"], :name => "index_linked_accounts_on_reset_password_token", :unique => true

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "unread",       :default => true
    t.boolean  "important",    :default => false
    t.integer  "group_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "user_location"
    t.string   "post_location"
    t.string   "source"
    t.integer  "pageviews"
    t.integer  "accuracy"
    t.integer  "inaccuracy"
    t.integer  "total_votes"
    t.decimal  "accuracy_ratio"
    t.decimal  "accuracy_percent"
    t.decimal  "trending_value"
    t.decimal  "karma"
    t.integer  "time_effective"
    t.boolean  "is_anonymous"
    t.string   "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "flagged",             :default => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "preferences", :force => true do |t|
    t.string   "feed_preference"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",       :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "total_pageviews"
    t.integer  "total_comments_number"
    t.integer  "total_posts_number"
    t.integer  "total_upvotes"
    t.integer  "total_downvotes"
    t.decimal  "reliability"
    t.decimal  "accuracy"
    t.decimal  "inaccuracy"
    t.decimal  "karma"
    t.integer  "comment_karma"
    t.integer  "newsworthiness"
    t.decimal  "peak_hotness"
    t.decimal  "peak_accuracy"
    t.decimal  "peak_view_popularity"
    t.decimal  "peak_listeners"
    t.string   "feed_preference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "role",                                  :default => "normal"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
