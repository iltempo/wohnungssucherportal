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

ActiveRecord::Schema.define(:version => 20110715200458) do

  create_table "_flats", :force => true do |t|
    t.string   "title"
    t.integer  "rooms"
    t.integer  "square_meters"
    t.string   "street"
    t.integer  "price"
    t.string   "url"
    t.date     "available_on"
    t.date     "available_until"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "neighbourhood"
    t.string   "contact_person"
    t.text     "image_links"
    t.integer  "priority"
    t.string   "state"
    t.text     "comment"
  end

  create_table "_schema_migrations", :primary_key => "version", :force => true do |t|
  end

  add_index "_schema_migrations", ["version"], :name => "unique_schema_migrations", :unique => true

  create_table "flats", :force => true do |t|
    t.string   "title"
    t.integer  "rooms"
    t.integer  "square_meters"
    t.string   "street"
    t.integer  "price"
    t.string   "url"
    t.date     "available_on"
    t.date     "available_until"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "neighbourhood"
    t.string   "contact_person"
    t.text     "image_links"
    t.integer  "priority"
    t.string   "state"
    t.text     "comment"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "visit_at"
  end

  add_index "flats", ["state"], :name => "index_flats_on_state"

end
