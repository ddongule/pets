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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180911001612) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_pets", force: :cascade do |t|
    t.string "image"
    t.string "happenDt"
    t.string "happenPlace"
    t.string "kindCd"
    t.string "colorCd"
    t.string "age"
    t.string "weight"
    t.string "processState"
    t.string "sexCd"
    t.string "neuterYn"
    t.string "specialMark"
    t.string "careNm"
    t.string "careAddr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "kind"
    t.string "color"
    t.string "sex"
    t.string "age_weight"
    t.string "happenPlace"
    t.string "happenDate"
    t.string "neuter"
    t.text "character"
    t.string "dog_number"
    t.string "orgName"
    t.string "processState"
    t.string "careName"
    t.string "careNumber"
    t.string "carePlace"
    t.string "image"
  end

end
