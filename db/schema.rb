ActiveRecord::Schema.define(version: 2019_07_03_092853) do

  create_table "course_subjects",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.integer "course_id"
    t.integer "subject_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "subject_id"],
      name: "index_course_subjects_on_course_id_and_subject_id",
    unique: true
    t.index ["course_id"], name: "index_course_subjects_on_course_id"
    t.index ["subject_id"], name: "index_course_subjects_on_subject_id"
  end

  create_table "course_users",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.integer "status", default: 0
    t.datetime "date_start"
    t.datetime "date_end"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_users_on_course_id"
    t.index ["user_id", "course_id"],
      name: "index_course_users_on_user_id_and_course_id",
      unique: true
    t.index ["user_id"], name: "index_course_users_on_user_id"
  end

  create_table "courses",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "duration"
    t.integer "duration_type", default: 0
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progress_user_tasks",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.integer "subject_user_id"
    t.integer "subject_task_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_task_id"],
      name: "index_progress_user_tasks_on_subject_task_id"
    t.index ["subject_user_id", "subject_task_id"],
      name: "index_progress_user_tasks_on_subject_user_id_and_subject_task_id",
      unique: true
    t.index ["subject_user_id"],
      name: "index_progress_user_tasks_on_subject_user_id"
  end

  create_table "subject_tasks",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.integer "subject_id"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id", "task_id"],
      name: "index_subject_tasks_on_subject_id_and_task_id",
      unique: true
    t.index ["subject_id"], name: "index_subject_tasks_on_subject_id"
    t.index ["task_id"], name: "index_subject_tasks_on_task_id"
  end

  create_table "subject_users",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.integer "course_user_id"
    t.integer "course_subject_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_subject_id"],
      name: "index_subject_users_on_course_subject_id"
    t.index ["course_user_id", "course_subject_id"],
      name: "index_subject_users_on_course_user_id_and_course_subject_id",
      unique: true
    t.index ["course_user_id"], name: "index_subject_users_on_course_user_id"
  end

  create_table "subjects",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users",
    options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci",
    force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.string "fullname"
    t.date "birthday"
    t.integer "gender", default: 1
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
