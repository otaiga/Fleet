class Removenullfrompolicy < ActiveRecord::Migration
  def up
  	remove_column :policies, :group_id, :integer, :null => false
  end

  def down
  	add_column :policies, :group_id, :integer, :null => false
  end
end
