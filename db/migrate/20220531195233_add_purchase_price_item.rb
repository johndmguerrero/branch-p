class AddPurchasePriceItem < ActiveRecord::Migration[7.0]
  def change
    change_table :order_items do |t|
      t.monetize :purchasing_price
    end
  end
end
