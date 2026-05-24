class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, null: false, default: 0
      t.references :category, type: :bigint, null: false, foreign_key: true
      t.string :sku, null: false
      t.string :image_urls, array: true, default: []
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :products, :sku, unique: true
    add_index :products, :deleted_at, where: "deleted_at IS NULL"
  end
end
