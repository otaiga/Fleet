class Modifyfieldstoinboundcalls < ActiveRecord::Migration
  def up
  	remove_column :calls_inbound_msisdns, :msisdn
  	add_column :calls_inbound_msisdns, :phonelist_id, :integer

  	remove_column :calls_outbound_msisdns, :msisdn
  	add_column :calls_outbound_msisdns, :phonelist_id, :integer

  	remove_column :sms_inbound_msisdns, :msisdn
  	add_column :sms_inbound_msisdns, :phonelist_id, :integer

  	remove_column :sms_outbound_msisdns, :msisdn
  	add_column :sms_outbound_msisdns, :phonelist_id, :integer
  end

  def down
  	add_column :calls_inbound_msisdns, :msisdn, :string
  	remove_column :calls_inbound_msisdns, :phonelist_id

  	add_column :calls_outbound_msisdns, :msisdn, :string
  	remove_column :calls_outbound_msisdns, :phonelist_id

  	add_column :sms_inbound_msisdns, :msisdn, :string
  	remove_column :sms_inbound_msisdns, :phonelist_id

  	add_column :sms_outbound_msisdns, :msisdn, :string
  	remove_column :sms_outbound_msisdns, :phonelist_id
  end
end

