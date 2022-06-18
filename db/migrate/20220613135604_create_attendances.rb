class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :user
      t.boolean :late, default: false
      t.integer :state
      t.string :remarks
      t.timestamps
    end
  end
end
