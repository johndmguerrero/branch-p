class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :message
      t.references :user, foreign_key: true
      t.references :notable, polymorphic: true
      t.timestamps
    end
  end
end
