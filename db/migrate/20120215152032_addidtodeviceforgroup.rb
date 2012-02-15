class Addidtodeviceforgroup < ActiveRecord::Migration
  def up
  	add_column :devices, :group_id, :integer, :null => false
  end

  def down
  	remove_column :devices, :group_id, :integer, :null => false
  end
end
