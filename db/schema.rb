# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_19_170739) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_service_area_codes", force: :cascade do |t|
    t.bigint "service_area_id", null: false
    t.string "sa_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_area_id"], name: "index_additional_service_area_codes_on_service_area_id"
  end

  create_table "digsite_infos", force: :cascade do |t|
    t.bigint "excavation_info_id", null: false
    t.string "lookup_by"
    t.string "location_type"
    t.string "subdivision"
    t.string "address_state"
    t.string "address_county"
    t.string "address_place"
    t.string "address_zip"
    t.string "address_num"
    t.string "address_street_prefix"
    t.string "address_street_name"
    t.string "address_street_type"
    t.string "address_street_suffix"
    t.string "near_street_state"
    t.string "near_street_county"
    t.string "near_street_place"
    t.string "near_street_prefix"
    t.string "near_street_name"
    t.string "near_street_type"
    t.string "near_street_suffix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["excavation_info_id"], name: "index_digsite_infos_on_excavation_info_id"
  end

  create_table "excavation_infos", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.string "type_of_work"
    t.string "work_done_for"
    t.string "project_duration"
    t.datetime "project_start_date"
    t.string "explosives"
    t.string "underground_overhead"
    t.string "horizontal_boring"
    t.string "whitelined"
    t.text "locate_instructions"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_excavation_infos_on_ticket_id"
  end

  create_table "excavators", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.string "company_name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "type"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "field_contact_name"
    t.string "field_contact_phone"
    t.string "field_contact_email"
    t.boolean "crew_onsite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_excavators_on_ticket_id"
  end

  create_table "intersections", force: :cascade do |t|
    t.bigint "digsite_info_id", null: false
    t.string "intersection_state"
    t.string "intersection_county"
    t.string "intersection_place"
    t.string "intersection_prefix"
    t.string "intersection_name"
    t.string "intersection_type"
    t.string "intersection_suffix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["digsite_info_id"], name: "index_intersections_on_digsite_info_id"
  end

  create_table "service_areas", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.string "primary_service_area_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_service_areas_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "contact_center"
    t.string "request_number"
    t.string "reference_request_number"
    t.string "version_number"
    t.string "sequence_number"
    t.string "request_type"
    t.string "request_action"
    t.datetime "request_taken_datetime"
    t.datetime "transmission_datetime"
    t.datetime "legal_datetime"
    t.datetime "response_due_datetime"
    t.datetime "restake_date"
    t.datetime "expiration_date"
    t.datetime "lp_meeting_accept_due_date"
    t.datetime "overhead_begin_date"
    t.datetime "overhead_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "well_known_texts", force: :cascade do |t|
    t.bigint "digsite_info_id", null: false
    t.string "wkt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["digsite_info_id"], name: "index_well_known_texts_on_digsite_info_id"
  end

  add_foreign_key "additional_service_area_codes", "service_areas"
  add_foreign_key "digsite_infos", "excavation_infos"
  add_foreign_key "excavation_infos", "tickets"
  add_foreign_key "excavators", "tickets"
  add_foreign_key "intersections", "digsite_infos"
  add_foreign_key "service_areas", "tickets"
  add_foreign_key "well_known_texts", "digsite_infos"
end
