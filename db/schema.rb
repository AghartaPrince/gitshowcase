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

ActiveRecord::Schema.define(version: 20170422023444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invitations", force: :cascade do |t|
    t.integer  "inviter_id"
    t.string   "invitee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "homepage"
    t.string   "repository"
    t.string   "description"
    t.string   "thumbnail"
    t.string   "language"
    t.integer  "position"
    t.boolean  "hide"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "syncing"
    t.boolean  "fork"
    t.integer  "stars"
    t.integer  "forks"
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "setup_covers", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "github_uid"
    t.string   "github_token"
    t.string   "name"
    t.string   "username"
    t.string   "avatar"
    t.string   "cover"
    t.string   "bio"
    t.string   "role"
    t.string   "location"
    t.string   "company"
    t.string   "company_website"
    t.string   "website"
    t.boolean  "hireable"
    t.json     "skills"
    t.string   "linkedin"
    t.string   "angellist"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "google_plus"
    t.string   "stack_overflow"
    t.string   "codepen"
    t.string   "jsfiddle"
    t.string   "medium"
    t.string   "blog"
    t.string   "behance"
    t.string   "dribbble"
    t.string   "pinterest"
    t.string   "display_email"
    t.string   "domain"
    t.boolean  "admin"
    t.integer  "plan_id"
    t.index ["domain"], name: "index_users_on_domain", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["plan_id"], name: "index_users_on_plan_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "invitations", "users", column: "inviter_id", on_delete: :cascade
  add_foreign_key "projects", "users", on_delete: :cascade
  add_foreign_key "users", "plans", column: "plan_id"
end
