class CreatePhonelists < ActiveRecord::Migration
  def change
    create_table :phonelists do |t|
      t.string :name
      t.integer :account_id, :null => false
      t.integer :policy_id
      t.timestamps
    end
  end
end
