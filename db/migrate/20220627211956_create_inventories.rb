class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :user
      t.references :branch
      t.integer :status
      t.string :type
      t.string :inventory_number
      t.string :remarks
      t.timestamps
    end
  end
end
