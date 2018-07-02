class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :whiskeys, :type, :whiskey_type
  end
end
