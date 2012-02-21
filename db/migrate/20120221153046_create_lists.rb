class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :member
      t.string :msisdn
      t.integer :phonelist_id
      t.timestamps
    end
  end
end
