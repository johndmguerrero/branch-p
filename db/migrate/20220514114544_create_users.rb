class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :account_number
      t.string :address
      t.references :branch
      t.timestamps
    end
  end
end
