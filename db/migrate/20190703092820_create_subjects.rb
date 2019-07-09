class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :description
      t.string :picture

      t.timestamps
    end
  end
end
