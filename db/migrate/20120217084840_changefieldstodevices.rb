class Changefieldstodevices < ActiveRecord::Migration

  def up
    add_column :devices, :msisdn, :string
    remove_column :devices, :make
  	remove_column :devices, :model
  end

  def down
    add_column :devices, :make, :string
  	add_column :devices, :model, :string
  	remove_column :devices, :msisdn
  end

end
