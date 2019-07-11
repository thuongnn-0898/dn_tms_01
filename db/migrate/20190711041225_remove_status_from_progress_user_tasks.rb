class RemoveStatusFromProgressUserTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :progress_user_tasks, :status
  end
end
