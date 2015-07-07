class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :amount
      t.integer :campaign_id
      t.integer :user_id
      t.timestamps
    end
    # add_index :campaign_id, :user_id
  end
end
