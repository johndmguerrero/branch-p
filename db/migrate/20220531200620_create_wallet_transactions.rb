class CreateWalletTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :wallet_transactions do |t|
      t.references :user, foreign_key: true
      t.references :wallet, foreign_key: true
      t.monetize :amount
      t.integer :status
      t.string :type
      t.string :remarks
      t.timestamps
    end
  end
end
