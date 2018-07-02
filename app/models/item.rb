class Item < ActiveRecord::Base
    belongs_to :user
    has_many :whiskey_items
    has_many :whiskeys, through: :whiskey_items
end