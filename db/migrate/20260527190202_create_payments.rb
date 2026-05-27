class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :order, type: :uuid, null: false, foreign_key: true
      t.string :cardholder_name
      t.string :card_last_four
      t.string :expiry

      t.timestamps
    end
  end
end
