class WhiskeyItem < ActiveRecord::Base
    belongs_to :item
    belongs_to :whiskey
end