class AddcolumstoDevice < ActiveRecord::Migration
  def up
  	add_column :devices, :name, :string
  	add_column :devices, :make, :string
  	add_column :devices, :model, :string
	add_column :devices, :account_id, :integer, :null => false
  end

  def down
  	remove_column :devices, :name, :string
  	remove_column :devices, :make, :string
  	remove_column :devices, :model, :string
	remove_column :devices, :account_id, :integer, :null => false
  end
end
