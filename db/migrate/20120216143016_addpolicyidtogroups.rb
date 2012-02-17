class Addpolicyidtogroups < ActiveRecord::Migration
  def up
    add_column :groups, :policy_id, :integer
  end

  def down
	remove_column :groups, :policy_id
  end
end
