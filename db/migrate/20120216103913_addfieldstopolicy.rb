class Addfieldstopolicy < ActiveRecord::Migration
  def up
    add_column :policies, :name, :string
	add_column :policies, :account_id, :integer, :null => false
  end

  def down
    remove_column :policies, :name
	remove_column :policies, :account_id
  end
end
