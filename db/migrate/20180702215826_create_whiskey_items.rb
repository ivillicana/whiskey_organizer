class CreateWhiskeyItems < ActiveRecord::Migration[5.2]
  def change
    create_table :whiskey_items do |t|
      t.integer :item_id
      t.integer :whiskey_id
    end
  end
end
