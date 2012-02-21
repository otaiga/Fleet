class AddphonelistIdtopolicy < ActiveRecord::Migration
  def up
  	add_column :policies, :phonelist_id, :integer
  end

  def down
  	remove_column :policies, :phonelist_id
  end
end
