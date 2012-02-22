class ModifyfieldstoPhonelists < ActiveRecord::Migration
  def up
  	add_column :phonelists, :calls_inbound_msisdn_id, :integer

  	add_column :phonelists, :calls_outbound_msisdn_id, :integer

  	add_column :phonelists, :sms_inbound_msisdn_id, :integer

  	add_column :phonelists, :sms_outbound_msisdn_id, :integer
  end

  def down
  	remove_column :phonelists, :calls_inbound_msisdn_id
  	remove_column :phonelists, :calls_outbound_msisdn_id
  	remove_column :phonelists, :sms_inbound_msisdn_id
  	remove_column :phonelists, :sms_outbound_msisdn_id
  end
end
