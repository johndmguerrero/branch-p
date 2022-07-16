class AddOriginInventory < ActiveRecord::Migration[7.0]
  def change
    change_table :inventories do |t|
      t.string :origin
    end
  end
end
