class Addfieldstopolicy < ActiveRecord::Migration
  def up
  add_column :policies, :name, :string
	add_column :policies, :account_id, :integer, :null => false
	add_column :policies, :group_id, :integer, :null => false
  end

  def down
  remove_column :policies, :name, :string
	remove_column :policies, :account_id, :integer, :null => false
	remove_column :policies, :group_id, :integer, :null => false
  end
end
