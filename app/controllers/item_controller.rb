class ItemController < ApplicationController

    get '/items' do
        redirect_if_not_logged_in
            @user = User.find(session[:user_id])
            @items = @user.items.sort_by {|i| i.whiskey.brand}
            erb :'/items/home'
    end

    get '/items/new' do
        redirect_if_not_logged_in
            @user = User.find(session[:user_id])
            @whiskeys = Whiskey.all
            erb :'items/new'
    end

    post '/items' do

        redirect_if_not_logged_in
            if valid_date? #Validates last_tasted_date
                if params[:item][:whiskey_id].empty? && params[:whiskey].all? {|k,v| !v.empty?}
                    #create an item with an existing whiskey
                    whiskey = Whiskey.create(params[:whiskey])
                    item = Item.create(last_tasted_date: params[:item][:last_tasted_date], whiskey_id:  whiskey.id, user_id: current_user.id)
                    redirect "/items/#{item.id}"
                elsif !params[:item][:whiskey_id].empty? && params[:whiskey].all? {|k,v| v.empty?}
                    #create an item with a new whiskey
                    item = Item.create(params[:item])
                    item.user = current_user
                    item.save
                    redirect "/items/#{item.id}"
                else
                    #error message if both options are selected
                    flash[:choose_one] = "Please add an existing whiskey OR create a new one"
                    redirect '/items/new'
                end
            else
                #error message is last_tasted_date is not filled out correctly
                flash[:date] = "Please add a valid date (e.g. 1964-06-14)"
                redirect '/items/new'
            end
    end

    get '/items/:id' do
        redirect_if_not_logged_in
            @item = Item.find(params[:id])
            @user = current_user
            erb :'/items/show'
    end

    get '/items/:id/edit' do
        redirect_if_not_logged_in
            @item = Item.find(params[:id])
            @user = current_user
            if @item.user == @user
                erb :'/items/edit'
            else
                redirect '/items'
            end
    end

    post '/items/:id' do
      redirect_if_not_logged_in
            item = Item.find(params[:id])
            user = current_user
            if item.user == user
                if valid_date?
                    item.last_tasted_date = params[:item][:last_tasted_date]
                    item.save
                    redirect "/items/#{item.id}"
                else
                    #error message is last_tasted_date is not filled out correctly
                    flash[:date] = "Please add a valid date (e.g. 1964-06-14)"
                    redirect "/items/#{item.id}/edit"
                end
            else
                redirect '/items'
            end
    end

    post '/items/:id/delete' do
      redirect_if_not_logged_in
            item = Item.find(params[:id])
            user = current_user
            if item.user == user
                item.destroy
            end
            redirect '/items'
    end

end
