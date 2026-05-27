class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :order, type: :uuid, null: false, foreign_key: true
      t.string :full_name
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
