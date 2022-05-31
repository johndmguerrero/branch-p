class AddRemarksInOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :remarks, :string
  end
end
