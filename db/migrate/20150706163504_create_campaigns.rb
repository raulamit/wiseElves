class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :original_amount_pledged
      t.integer :amount_contributed
      t.date :start_date
      t.date :end_date
      t.string :status

      t.integer :campaigner_id
      t.integer :beneficiary_id
      t.timestamps
    end
    # add_index :campaigner_id, :beneficiary_id
  end
end
