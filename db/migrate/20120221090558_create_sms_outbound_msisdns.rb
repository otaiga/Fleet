class CreateSmsOutboundMsisdns < ActiveRecord::Migration
  def change
    create_table :sms_outbound_msisdns do |t|
      t.string :msisdn
      t.integer :policy_id
      
      t.timestamps
    end
  end
end
