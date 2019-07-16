class AddFieldsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :subject_id, :integer
  end
end
