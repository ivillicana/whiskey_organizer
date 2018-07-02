users_list = [
    "Donald Trump" => {
        :name => "Donald Trump",
        :username => "dTrump",
        :password => "password1",
        :email => "dtrump@gmail.com"
    },
    "Barack Obama" => {
        :name => "Barack Obama",
        :username => "bObama",
        :password => "password2",
        :email => "bobama@gmail.com"
    },
    "George W Bush" => {
        :name => "George W Bush",
        :username => "gwBush",
        :password => "password3",
        :email => "gwbush@gmail.com"
    }
]

users_list.each do |user_array|
    user_array.each do |user, user_hash|
        User.create(user_hash)
    end
end

whiskey_list = [
    1 => {
        :brand => "Lagavulin",
        :name => "16 Years",
        :type => "Sotch"
    },
    2 => {
        :brand => "Jack Daniel's",
        :name => "Gentleman Jack",
        :type => "Tennessee Whiskey"
    },
    3 => {
        :brand => "Jack Daniel's",
        :name => "Old No. 7",
        :type => "Tennessee Whiskey"
    },
    4 => {
        :brand => "Crown Royal",
        :name => "Reserve",
        :type => "Canadian Whisky"
    }
]

whiskey_list.each do |whiskey_array|
    whiskey_array. each do |whiskey, whiskey_hash|
        Whiskey.create(whiskey_hash)
    end
end

items_list = [
    1 => {
        :last_tasted_date => "2016-12-05",
        :user_id => 1,
        :whiskey_id => 1
    },
    2 => {
        :last_tasted_date => "2016-11-03",
        :user_id => 1,
        :whiskey_id => 2
    },
    3 => {
        :last_tasted_date => "1990-01-01",
        :user_id => 2,
        :whiskey_id => 1
    },
    4 => {
        :last_tasted_date => "2017-07-04",
        :user_id => 3,
        :whiskey_id => 3
    },
    5 => {
        :last_tasted_date => "2018-03-03",
        :user_id => 2,
        :whiskey_id => 3
    },
    6 => {
        :last_tasted_date => "2017-06-19",
        :user_id => 3,
        :whiskey_id => 4
    }
]

items_list.each do |items_array|
    items_array.each do |item, item_hash|
        Item.create(item_hash)
    end
end