class Addmorefieldstopolicy < ActiveRecord::Migration
  def up
  	add_column :policies, :voice, :boolean
  	add_column :policies, :messaging, :boolean
  	add_column :policies, :maps, :boolean
  	add_column :policies, :phonebook, :boolean
  	add_column :policies, :browsing, :boolean
  	add_column :policies, :notes, :boolean
  end

  def down
  	remove_column :policies, :voice
  	remove_column :policies, :messaging
  	remove_column :policies, :maps
  	remove_column :policies, :phonebook
  	remove_column :policies, :browsing
  	remove_column :policies, :notes
  end
end
