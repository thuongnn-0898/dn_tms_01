class RemoveFieldsFromCourseUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :course_users, :status, :integer
    remove_column :course_users, :date_start, :datetime
    remove_column :course_users, :date_end, :datetime
  end
end
