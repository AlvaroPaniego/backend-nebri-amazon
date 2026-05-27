class AddTrackingCodeToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :tracking_code, :string
    add_index :orders, :tracking_code, unique: true
  end
end
