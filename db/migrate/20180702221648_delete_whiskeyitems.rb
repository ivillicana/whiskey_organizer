class DeleteWhiskeyitems < ActiveRecord::Migration[5.2]
  def change
    drop_table :whiskey_items
  end
end
