class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :role, default: User.role_types[:trainee]
      t.string :fullname
      t.date :birthday
      t.integer :gender, default: User.gender_types[:male]
      t.string :avatar

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
