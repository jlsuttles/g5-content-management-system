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

ActiveRecord::Schema.define(:version => 20130418180107) do

  create_table "clients", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "features", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.boolean  "corporate"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "urn"
    t.string   "primary_color",   :default => "#000000"
    t.string   "secondary_color", :default => "#ffffff"
    t.boolean  "custom_colors",   :default => false,     :null => false
  end

  add_index "locations", ["urn"], :name => "index_locations_on_urn"

  create_table "page_layouts", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "page_id"
    t.text     "html"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "thumbnail"
    t.text     "stylesheets"
  end

  add_index "page_layouts", ["page_id"], :name => "index_page_layouts_on_page_id"

  create_table "pages", :force => true do |t|
    t.integer  "location_id"
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "slug"
    t.boolean  "template",    :default => false
    t.string   "type",        :default => "Page"
    t.string   "title"
    t.boolean  "disabled",    :default => false
  end

  add_index "pages", ["location_id"], :name => "index_pages_on_location_id"

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.boolean  "editable",          :default => false
    t.string   "default_value"
    t.integer  "property_group_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "property_groups", :force => true do |t|
    t.integer  "component_id"
    t.string   "component_type"
    t.string   "name"
    t.text     "categories"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "sibling_deploys", :force => true do |t|
    t.integer  "sibling_id"
    t.integer  "instruction_id"
    t.boolean  "manual"
    t.string   "state"
    t.string   "git_repo"
    t.string   "heroku_repo"
    t.string   "heroku_app_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sibling_instructions", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.datetime "published_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "siblings", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "git_repo"
    t.string   "heroku_repo"
    t.string   "heroku_app_name"
    t.boolean  "main_app"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "themes", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "page_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "thumbnail"
    t.text     "stylesheets"
    t.text     "javascripts"
    t.text     "colors"
  end

  add_index "themes", ["page_id"], :name => "index_themes_on_page_id"

  create_table "widget_entries", :force => true do |t|
    t.integer  "widget_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "widgets", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "page_id"
    t.integer  "position"
    t.text     "html"
    t.text     "stylesheets"
    t.text     "javascripts"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "thumbnail"
    t.string   "section"
    t.text     "edit_form_html"
  end

  add_index "widgets", ["name"], :name => "index_widgets_on_name"
  add_index "widgets", ["page_id"], :name => "index_widgets_on_page_id"

end
