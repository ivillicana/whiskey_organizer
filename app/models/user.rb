class User < ActiveRecord::Base
    has_many :items
    has_many :whiskeys, through: :items
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true

    has_secure_password

    def slug
        self.username.gsub(" ", "-").downcase
    end

    def self.find_by_slug(arg)
        self.all.find {|user| user.slug == arg}
    end
end
