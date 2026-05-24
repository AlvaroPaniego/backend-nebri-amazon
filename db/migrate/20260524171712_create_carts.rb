class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
    add_index :carts, :user_id, unique: true, name: 'index_carts_on_user_id_unique'
  end
end
