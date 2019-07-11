class RenameSubjectTaskIdToTaskId < ActiveRecord::Migration[5.2]
  def change
    rename_column :progress_user_tasks, :subject_task_id, :task_id
  end
end
