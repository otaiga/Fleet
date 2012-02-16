class Removenullfrompolicy3 < ActiveRecord::Migration
  def up
    add_column :policies, :group_id, :integer
  end

  def down
  	remove_column :policies, :group_id, :integer
  end
end
