class AddTypeInOrderItems < ActiveRecord::Migration[7.0]
  def change
    change_table :order_items do |t|
      t.string :type
    end
  end
end
