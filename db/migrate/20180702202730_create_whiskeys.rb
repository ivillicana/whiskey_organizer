class CreateWhiskeys < ActiveRecord::Migration[5.2]
  def change
    create_table :whiskeys do |t|
      t.string :brand
      t.string :name
      t.string :type
      t.timestamps
    end
  end
end
