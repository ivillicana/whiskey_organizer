class User < ActiveRecord::Base
    has_many :items
    has_many :whiskeys, through: :items

    has_secure_password
end