class AddFieldsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :id_subject, :integer
  end
end
