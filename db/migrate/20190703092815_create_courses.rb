class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.integer :duration
      t.integer :duration_type, default: Course.status_types[:init]
      t.string :picture

      t.timestamps
    end
  end
end
