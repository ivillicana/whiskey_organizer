class User < ActiveRecord::Base
    has_many :whiskeys
    has_many :items

    has_secure_password
end