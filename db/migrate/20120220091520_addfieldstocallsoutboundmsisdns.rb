class Addfieldstocallsoutboundmsisdns < ActiveRecord::Migration
  def up
  	add_column :calls_inbound_msisdns, :policy_id, :integer
  	add_column :calls_inbound_msisdns, :msisdn, :string
  end

  def down
  	remove_column :calls_inbound_msisdns, :policy_id
  	remove_column :calls_inbound_msisdns, :msisdn
  end
end
