class ItemController < ApplicationController

    get '/items' do
        if Helper.logged_in?(session)
            @user = User.find(session[:user_id])
            @items = @user.items
            erb :'/items/home'
        else
            redirect '/login'
        end
    end

    get '/items/:id' do
        if Helper.logged_in?(session)
            @item = Item.find(params[:id])
            @user = Helper.current_user(session)
            if @item.user == @user
                erb :'/items/show'
            else
                redirect '/items'
            end
        else
            redirect '/login'
        end
    end

    get '/items/:id/edit' do
        if Helper.logged_in?(session)
            @item = Item.find(params[:id])
            @user = Helper.current_user(session)
            if @item.user == @user
                erb :'/items/edit'
            else
                redirect '/items'
            end
        else
            redirect '/login'
        end
    end

    post '/items/:id' do
        if Helper.logged_in?(session)
            item = Item.find(params[:id])
            user = Helper.current_user(session)
            if item.user = user
                binding.pry
                if !params[:item][:last_tasted_date].empty?
                    item.last_tasted_date = params[:item][:last_tasted_date]
                    item.save
                    redirect "/items/#{item.id}"
                else
                    redirect "/items/#{item.id}/edit"
                end
            else
                redirect '/items'
            end
        else
            redirect '/login'
        end
    end

end
