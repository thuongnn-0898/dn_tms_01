class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :role, default: 0
      t.string :fullname
      t.date :birthday
      t.integer :gender, default: 1
      t.string :avatar

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
