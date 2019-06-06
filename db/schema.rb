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

ActiveRecord::Schema.define(version: 2019_06_06_061621) do

  create_table "book_keepers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_book_keepers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_book_keepers_on_reset_password_token", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.integer "no_of_copies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
  end

  create_table "issue_details", force: :cascade do |t|
    t.integer "student_id"
    t.integer "book_id"
    t.date "issue_date"
    t.date "exp_recieved_date"
    t.date "act_recieved_date"
    t.integer "fine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transaction_id"
    t.index ["book_id", "student_id"], name: "index_issue_details_on_book_id_and_student_id"
    t.index ["book_id"], name: "index_issue_details_on_book_id"
    t.index ["student_id"], name: "index_issue_details_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

end
