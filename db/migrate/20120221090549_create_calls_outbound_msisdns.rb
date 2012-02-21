class CreateCallsOutboundMsisdns < ActiveRecord::Migration
  def change
    create_table :calls_outbound_msisdns do |t|
      t.string :msisdn
      t.integer :policy_id

      t.timestamps
    end
  end
end
