class CreateSubjectUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :subject_users do |t|
      t.integer :course_user_id
      t.integer :course_subject_id
      t.integer :status, default: SubjectUser.status_types[:init]

      t.timestamps
    end

    add_index :subject_users, :course_user_id
    add_index :subject_users, :course_subject_id

    add_index :subject_users, [:course_user_id, :course_subject_id],
      unique: true
  end
end
