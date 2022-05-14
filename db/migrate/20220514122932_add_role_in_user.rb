class AddRoleInUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.integer :role
    end
  end
end
