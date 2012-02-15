class Addfieldstogroup < ActiveRecord::Migration
  def up
  	add_column :groups, :name, :string
	add_column :groups, :account_id, :integer, :null => false
  end

  def down
  	remove_column :groups, :name, :string
	remove_column :groups, :account_id, :integer, :null => false
  end
end
