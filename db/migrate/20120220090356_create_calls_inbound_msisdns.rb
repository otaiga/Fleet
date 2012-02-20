class CreateCallsInboundMsisdns < ActiveRecord::Migration
  def change
    create_table :calls_inbound_msisdns do |t|

      t.timestamps
    end
  end
end
