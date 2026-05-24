class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :status, null: false
      t.decimal :total_price, precision: 12, scale: 2, null: false

      t.timestamps
    end
    add_index :orders, :created_at
  end
end
