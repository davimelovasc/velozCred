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

ActiveRecord::Schema.define(version: 20180524125806) do

  create_table "agent_auxes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "key_j", null: false
    t.string "role", null: false
    t.string "uf", null: false
    t.string "ctps_cda"
    t.float "commission_percent", limit: 24
    t.string "prefix"
    t.string "account"
    t.string "account_type"
    t.float "extra", limit: 24
    t.float "discount", limit: 24
    t.float "vr_comis_account", limit: 24
    t.date "activity_start"
    t.boolean "cost_help"
    t.text "obs"
    t.integer "regional_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.string "name", null: false
    t.string "key_j", null: false
    t.string "email", null: false
    t.string "cpf", null: false
    t.string "role", null: false
    t.string "uf", null: false
    t.string "ctps_cda"
    t.float "commission_percent", limit: 24
    t.string "prefix"
    t.string "account"
    t.string "account_type"
    t.float "extra", limit: 24
    t.float "discount", limit: 24
    t.float "vr_comis_account", limit: 24
    t.date "activity_start"
    t.boolean "cost_help"
    t.text "obs"
    t.integer "regional_id"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_changed", default: false
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_agents_on_uid_and_provider", unique: true
  end

  create_table "daily_productions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "agent_id"
    t.float "goal", limit: 24
    t.float "value", limit: 24
    t.float "miss", limit: 24
    t.float "miss_percent", limit: 24
    t.float "goal_du", limit: 24
    t.float "miss_du", limit: 24
    t.float "du_percent", limit: 24
    t.float "d_one", limit: 24
    t.float "d_two", limit: 24
    t.float "d_three", limit: 24
    t.float "d_four", limit: 24
    t.float "d_five", limit: 24
    t.float "d_six", limit: 24
    t.float "d_seven", limit: 24
    t.float "d_eight", limit: 24
    t.float "d_nine", limit: 24
    t.float "d_ten", limit: 24
    t.float "d_eleven", limit: 24
    t.float "d_twelve", limit: 24
    t.float "d_thirteen", limit: 24
    t.float "d_fourteen", limit: 24
    t.float "d_fiveteen", limit: 24
    t.float "d_sixteen", limit: 24
    t.float "d_seventeen", limit: 24
    t.float "d_eighteen", limit: 24
    t.float "d_nineteen", limit: 24
    t.float "d_twenty", limit: 24
    t.float "d_twentyone", limit: 24
    t.float "d_twentytwo", limit: 24
    t.float "d_twentythree", limit: 24
    t.integer "n_one"
    t.integer "n_two"
    t.integer "n_three"
    t.integer "n_four"
    t.integer "n_five"
    t.integer "n_six"
    t.integer "n_seven"
    t.integer "n_eight"
    t.integer "n_nine"
    t.integer "n_ten"
    t.integer "n_eleven"
    t.integer "n_twelve"
    t.integer "n_thirteen"
    t.integer "n_fourteen"
    t.integer "n_fiveteen"
    t.integer "n_sixteen"
    t.integer "n_seventeen"
    t.integer "n_eighteen"
    t.integer "n_nineteen"
    t.integer "n_twenty"
    t.integer "n_twentyone"
    t.integer "n_twentytwo"
    t.integer "n_twentythree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regionals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "agent_id"
    t.string "name", null: false
    t.string "company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cod_regional", default: 0, null: false
  end

  create_table "segments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "ord_segment"
    t.string "segment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "total_productions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "segment_id"
    t.integer "agent_id"
    t.date "year_month", null: false
    t.float "goal", limit: 24
    t.float "production_value", limit: 24
    t.float "goal_percent", limit: 24
    t.float "remuneration", limit: 24
    t.float "remunaration_percent", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
