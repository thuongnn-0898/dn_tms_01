class CreateProgressUserTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :progress_user_tasks do |t|
      t.integer :subject_user_id
      t.integer :subject_task_id
      t.integer :status, default: ProgressUserTask.status_types[:init]

      t.timestamps
    end

    add_index :progress_user_tasks, :subject_user_id
    add_index :progress_user_tasks, :subject_task_id

    add_index :progress_user_tasks, [:subject_user_id, :subject_task_id],
      unique: true
  end
end
