class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.string :order_number
      t.monetize :total
      t.monetize :subtotal
      t.datetime :completed_at
      t.references :branch
      t.references :user
      t.timestamps
    end
  end
end
