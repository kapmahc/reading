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

ActiveRecord::Schema.define(version: 20161123182011) do

  create_table "reading_books", force: :cascade do |t|
    t.string   "author",                   null: false
    t.string   "publisher",                null: false
    t.string   "title",                    null: false
    t.string   "flag",                     null: false
    t.string   "lang",                     null: false
    t.string   "subject",                  null: false
    t.text     "description"
    t.text     "home",                     null: false
    t.integer  "vote",         default: 0, null: false
    t.date     "published_at",             null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["author"], name: "index_reading_books_on_author"
    t.index ["flag"], name: "index_reading_books_on_flag"
    t.index ["lang"], name: "index_reading_books_on_lang"
    t.index ["publisher"], name: "index_reading_books_on_publisher"
    t.index ["subject"], name: "index_reading_books_on_subject"
    t.index ["title"], name: "index_reading_books_on_title"
  end

  create_table "reading_favorites", force: :cascade do |t|
    t.string   "resource_type", null: false
    t.integer  "resource_id",   null: false
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["resource_type", "resource_id", "user_id"], name: "idx_reading_favorites_ids", unique: true
    t.index ["resource_type"], name: "index_reading_favorites_on_resource_type"
    t.index ["user_id"], name: "index_reading_favorites_on_user_id"
  end

  create_table "reading_notes", force: :cascade do |t|
    t.string   "flag",            limit: 8,             null: false
    t.text     "body",                                  null: false
    t.integer  "vote",                      default: 0, null: false
    t.integer  "reading_book_id"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["flag"], name: "index_reading_notes_on_flag"
    t.index ["reading_book_id"], name: "index_reading_notes_on_reading_book_id"
    t.index ["user_id"], name: "index_reading_notes_on_user_id"
  end

end
