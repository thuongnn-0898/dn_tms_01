class DropSubjectTasks < ActiveRecord::Migration[5.2]
  def change
    drop_table :subject_tasks do |t|
      t.integer :subject_id
      t.integer :task_id

      t.timestamps
    end
  end
end
