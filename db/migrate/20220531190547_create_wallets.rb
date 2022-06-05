class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :branch, foreign_key: true
      t.monetize :balance
      t.timestamps
    end
  end
end
