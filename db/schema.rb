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

ActiveRecord::Schema.define(:version => 20080824182835) do

  create_table "associations", :force => true do |t|
    t.integer  "model_id"
    t.integer  "foreign_model_id"
    t.string   "association_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "columns", :force => true do |t|
    t.integer  "model_id"
    t.string   "name"
    t.string   "column_type"
    t.string   "default_value"
    t.boolean  "appears_in_views", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "controllers", :force => true do |t|
    t.integer  "model_id"
    t.string   "name"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "parent_id"
    t.string   "namespace"
    t.boolean  "responds_to_html"
    t.boolean  "responds_to_xml"
    t.boolean  "responds_to_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.integer  "site_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "skip_timestamps", :default => false
  end

  create_table "plugins", :force => true do |t|
    t.string   "name"
    t.string   "remote_url"
    t.string   "local_path"
    t.string   "generator_name"
    t.text     "default_generator_argument"
    t.boolean  "selected_by_default",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selected_plugins", :force => true do |t|
    t.integer  "site_id"
    t.integer  "plugin_id"
    t.text     "generator_argument"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "state"
    t.string   "scm"
    t.string   "rails_version"
    t.boolean  "vendor_rails",          :default => false
    t.string   "test_framework"
    t.string   "views_type"
    t.boolean  "capify",                :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "generation_start_time"
    t.datetime "generation_stop_time"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "validations", :force => true do |t|
    t.integer  "column_id"
    t.string   "validation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worker_queue_items", :force => true do |t|
    t.string   "task_name"
    t.string   "task_group"
    t.string   "class_name"
    t.string   "method_name"
    t.text     "argument_hash"
    t.text     "data",          :limit => 268435457
    t.datetime "start"
    t.integer  "status",                             :default => 0, :null => false
    t.string   "error_message"
    t.string   "filename"
    t.integer  "lock_version",                       :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "worker_queue_items", ["status"], :name => "index_worker_queue_items_on_status"

end
