class AddRemarksVoidIntentory < ActiveRecord::Migration[7.0]
  def change
    change_table :inventories do |t|
      t.string :void_remarks
    end
  end
end
