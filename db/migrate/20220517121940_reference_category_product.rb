class ReferenceCategoryProduct < ActiveRecord::Migration[7.0]
  def change
    change_table :products do |t|
      t.references :category
      t.references :branch
      t.integer :status
      t.integer :quantity
    end
  end
end
