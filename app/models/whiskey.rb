class Whiskey < ActiveRecord::Base
    has_many :whiskey_items
    has_many :items, through: :whiskey_items
    has_many :users, through: :items
end