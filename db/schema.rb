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

ActiveRecord::Schema.define(:version => 20121124001649) do

  create_table "donors", :force => true do |t|
    t.string   "name"
    t.string   "affiliation"
    t.string   "address_raw"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "image_uri"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "gift_types", :force => true do |t|
    t.string   "gift_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gifts", :force => true do |t|
    t.string   "description"
    t.decimal  "value"
    t.integer  "gift_type_id"
    t.date     "date_given"
    t.string   "address_raw"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "image_uri"
    t.integer  "donor_id"
    t.integer  "judge_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "judges", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "agency"
    t.string   "position"
    t.string   "division"
    t.string   "image_uri"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_foreign_key "gifts", "donors", :name => "gifts_donor_id_fk"
  add_foreign_key "gifts", "judges", :name => "gifts_judge_id_fk"

end
