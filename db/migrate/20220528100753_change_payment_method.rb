class ChangePaymentMethod < ActiveRecord::Migration[7.0]
  def change
    remove_column :payments, :payment_method, :string
    add_column :payments, :payment_method, :integer
  end
end
