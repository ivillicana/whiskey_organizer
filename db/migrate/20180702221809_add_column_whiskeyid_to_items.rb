class AddColumnWhiskeyidToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :whiskey_id, :integer
  end
end
