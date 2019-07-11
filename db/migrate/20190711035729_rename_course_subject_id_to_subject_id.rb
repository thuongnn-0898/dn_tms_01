class RenameCourseSubjectIdToSubjectId < ActiveRecord::Migration[5.2]
  def change
    rename_column :subject_users, :course_subject_id, :subject_id
  end
end
