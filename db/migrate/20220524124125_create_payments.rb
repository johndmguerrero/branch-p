class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.monetize :amount_paid
      t.monetize :change
      t.integer :status
      t.string :transaction_id
      t.datetime :paid_at
      t.string :payment_method
      t.timestamps
    end
  end
end
