class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :login
      t.string :full_name
      t.date   :birthday
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :password_digest

      t.timestamps null: false
    end

    add_index :members, :login, unique: true
    add_index :members, :email, unique: true
  end
end
