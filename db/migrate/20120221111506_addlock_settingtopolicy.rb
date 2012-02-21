class AddlockSettingtopolicy < ActiveRecord::Migration
  def up
  	add_column :policies, :lock, :boolean
  	add_column :policies, :lock_pin, :string
  end

  def down
  	remove_column :policies, :lock
  	remove_column :policies, :lock_pin
  end
end
