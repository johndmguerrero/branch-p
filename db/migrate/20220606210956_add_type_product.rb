class AddTypeProduct < ActiveRecord::Migration[7.0]
  def change
    change_table :products do |t|
      t.string :type
    end
  end
end
