class ItemController < ApplicationController

    get '/items' do
        if Helper.logged_in?(session)
            @user = User.find(session[:user_id])
            @items = @user.items
            erb :'/items/show'
        else
            redirect '/login'
        end
    end

end
