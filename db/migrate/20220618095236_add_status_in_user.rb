class AddStatusInUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.integer :status
    end
  end
end
