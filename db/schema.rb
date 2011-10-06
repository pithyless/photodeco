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

ActiveRecord::Schema.define(:version => 20110921103700) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
    t.index ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], :name => "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"
  end

  create_table "providers", :force => true do |t|
    t.string   "name",       :limit => 120, :null => false
    t.string   "slug",       :limit => 60,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "provider_id",                                                   :null => false
    t.string   "title",                       :limit => 120,                    :null => false
    t.text     "description"
    t.string   "author"
    t.text     "credit"
    t.text     "source"
    t.text     "copyright"
    t.text     "notes"
    t.datetime "taken_at"
    t.datetime "digitized_at"
    t.string   "image",                                                         :null => false
    t.string   "image_secure_token",          :limit => 10,                     :null => false
    t.string   "image_original_secure_token", :limit => 10,                     :null => false
    t.string   "image_original_filename",     :limit => 120,                    :null => false
    t.boolean  "moderated",                                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider_id"], :name => "index_photos_on_provider_id"
    t.foreign_key ["provider_id"], "providers", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "photos_provider_id_fkey"
  end

  create_table "stores", :force => true do |t|
    t.string   "name",       :limit => 120, :null => false
    t.string   "slug",       :limit => 120, :null => false
    t.string   "domain",     :limit => 120, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["domain"], :name => "index_stores_on_domain", :unique => true
    t.index ["slug"], :name => "index_stores_on_slug", :unique => true
  end

  create_table "products", :force => true do |t|
    t.integer  "photo_id",                      :null => false
    t.integer  "store_id",                      :null => false
    t.boolean  "published",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["photo_id"], :name => "index_products_on_photo_id"
    t.index ["store_id", "photo_id"], :name => "index_products_on_store_id_and_photo_id", :unique => true
    t.foreign_key ["photo_id"], "photos", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "products_photo_id_fkey"
    t.foreign_key ["store_id"], "stores", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "products_store_id_fkey"
  end

  create_table "users", :force => true do |t|
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
    t.string   "first_name",                                            :null => false
    t.string   "last_name",                                             :null => false
    t.string   "role",                                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  end

end
