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

ActiveRecord::Schema.define(version: 20180529011343) do

  create_table "agent_auxes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "key_j", null: false
    t.string "role", null: false
    t.string "uf"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "regional_id"
    t.bigint "agent_id"
    t.index ["agent_id"], name: "index_agent_auxes_on_agent_id"
    t.index ["regional_id"], name: "index_agent_auxes_on_regional_id"
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
    t.boolean "is_changed", default: false
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_agents_on_uid_and_provider", unique: true
  end

  create_table "daily_productions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.string "n_one"
    t.string "n_two"
    t.string "n_three"
    t.string "n_four"
    t.string "n_five"
    t.string "n_six"
    t.string "n_seven"
    t.string "n_eight"
    t.string "n_nine"
    t.string "n_ten"
    t.string "n_eleven"
    t.string "n_twelve"
    t.string "n_thirteen"
    t.string "n_fourteen"
    t.string "n_fiveteen"
    t.string "n_sixteen"
    t.string "n_seventeen"
    t.string "n_eighteen"
    t.string "n_nineteen"
    t.string "n_twenty"
    t.string "n_twentyone"
    t.string "n_twentytwo"
    t.string "n_twentythree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "agent_aux_id"
    t.index ["agent_aux_id"], name: "index_daily_productions_on_agent_aux_id"
  end

  create_table "regionals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.integer "cod_regional", default: 0, null: false
    t.string "company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "agent_aux_id"
    t.index ["agent_aux_id"], name: "index_regionals_on_agent_aux_id"
  end

  create_table "segments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "segment", null: false
    t.integer "ord_segment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "total_productions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "goal", limit: 24
    t.float "production_value", limit: 24
    t.float "goal_percent", limit: 24
    t.float "remuneration", limit: 24
    t.float "remunaration_percent", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "agent_aux_id"
    t.bigint "segment_id"
    t.bigint "year_month_id"
    t.index ["agent_aux_id"], name: "index_total_productions_on_agent_aux_id"
    t.index ["segment_id"], name: "index_total_productions_on_segment_id"
    t.index ["year_month_id"], name: "index_total_productions_on_year_month_id"
  end

  create_table "year_months", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "year_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "agent_auxes", "agents"
  add_foreign_key "agent_auxes", "regionals"
  add_foreign_key "daily_productions", "agent_auxes"
  add_foreign_key "regionals", "agent_auxes"
  add_foreign_key "total_productions", "agent_auxes"
  add_foreign_key "total_productions", "segments"
  add_foreign_key "total_productions", "year_months"
end
