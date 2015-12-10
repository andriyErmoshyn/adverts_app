class AddRoleColumnToMembers < ActiveRecord::Migration
  def change
    add_column :members, :role, :integer, :default => 1
  end
end
