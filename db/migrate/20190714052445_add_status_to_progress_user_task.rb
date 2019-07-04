class AddStatusToProgressUserTask < ActiveRecord::Migration[5.2]
  def change
    add_column :progress_user_tasks, :status, :integer
  end
end
