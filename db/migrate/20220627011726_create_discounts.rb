class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.references :discountable, polymorphic: true, index: true
      t.monetize :amount
      t.float :percent
      t.integer :off_type
      t.timestamps
    end
  end
end
