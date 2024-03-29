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

ActiveRecord::Schema.define(:version => 20130519155043) do

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "file"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "documents", ["page_id"], :name => "index_documents_on_page_id"

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "galleries", ["page_id"], :name => "index_galleries_on_page_id"

  create_table "menus", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.integer  "parent_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "is_valid",   :default => true
  end

  add_index "menus", ["parent_id"], :name => "index_menus_on_parent_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "short_text"
    t.text     "long_text"
    t.string   "maintainer"
    t.string   "content_type"
    t.text     "content"
    t.integer  "menu_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "pages", ["menu_id"], :name => "index_pages_on_menu_id"

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "position"
    t.integer  "gallery_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pictures", ["gallery_id"], :name => "index_pictures_on_gallery_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
