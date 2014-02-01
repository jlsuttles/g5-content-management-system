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

ActiveRecord::Schema.define(:version => 20140201005557) do

  create_table "clients", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "vertical"
  end

  create_table "drop_targets", :force => true do |t|
    t.integer  "web_template_id"
    t.string   "html_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.boolean  "corporate"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "urn"
    t.string   "state"
    t.string   "city"
    t.string   "street_address"
    t.string   "postal_code"
    t.string   "domain"
    t.string   "city_slug"
    t.string   "phone_number"
  end

  add_index "locations", ["urn"], :name => "index_locations_on_urn"

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "editable",      :default => false
    t.string   "default_value"
    t.integer  "owner_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "owner_type"
    t.text     "categories"
    t.integer  "priority"
    t.integer  "website_id"
  end

  add_index "settings", ["website_id"], :name => "index_settings_on_website_id"

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

  create_table "web_layouts", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "web_template_id"
    t.text     "html"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "thumbnail"
    t.text     "stylesheets"
  end

  add_index "web_layouts", ["web_template_id"], :name => "index_web_layouts_on_web_template_id"

  create_table "web_templates", :force => true do |t|
    t.integer  "website_id"
    t.string   "name"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "slug"
    t.boolean  "template",          :default => false
    t.string   "title"
    t.string   "type"
    t.boolean  "enabled"
    t.integer  "display_order"
    t.string   "redirect_patterns"
    t.boolean  "in_trash"
  end

  add_index "web_templates", ["website_id"], :name => "index_web_templates_on_website_id"

  create_table "web_themes", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "web_template_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "thumbnail"
    t.text     "stylesheets"
    t.text     "javascripts"
    t.text     "colors"
    t.boolean  "custom_colors"
    t.string   "custom_primary_color"
    t.string   "custom_secondary_color"
  end

  add_index "web_themes", ["web_template_id"], :name => "index_web_themes_on_web_template_id"

  create_table "websites", :force => true do |t|
    t.integer  "location_id"
    t.string   "urn"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "websites", ["location_id"], :name => "index_websites_on_location_id"

  create_table "widget_entries", :force => true do |t|
    t.integer  "widget_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "widgets", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "drop_target_id"
    t.integer  "display_order"
    t.text     "html"
    t.text     "stylesheets"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "thumbnail"
    t.string   "section"
    t.text     "edit_form_html"
    t.boolean  "removeable"
    t.string   "edit_javascript"
    t.string   "show_javascript"
    t.text     "lib_javascripts"
  end

  add_index "widgets", ["drop_target_id"], :name => "index_widgets_on_web_template_id"
  add_index "widgets", ["name"], :name => "index_widgets_on_name"

end
