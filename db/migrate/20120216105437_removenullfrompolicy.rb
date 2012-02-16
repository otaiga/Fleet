class Removenullfrompolicy < ActiveRecord::Migration
  def up
  	change_column :policies, :group_id, :integer
  end

  def down
  	change_column :policies, :group_id, :integer, :null => false
  end
end
