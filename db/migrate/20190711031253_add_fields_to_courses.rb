class AddFieldsToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :status, :integer,
      default: 0
    add_column :courses, :date_end, :datetime
    add_column :courses, :date_start, :datetime
  end
end
