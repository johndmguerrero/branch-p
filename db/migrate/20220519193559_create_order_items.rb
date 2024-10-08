class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :status
      t.integer :quantity
      t.monetize :subtotal
      t.monetize :total
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
