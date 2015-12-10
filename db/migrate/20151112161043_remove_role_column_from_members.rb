class RemoveRoleColumnFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :role
  end
end
