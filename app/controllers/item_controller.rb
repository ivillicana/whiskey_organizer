class ItemController < ApplicationController

    get '/items' do
        if logged_in?
            @user = User.find(session[:user_id])
            @items = @user.items
            erb :'/items/home'
        else
            redirect '/login'
        end
    end

    get '/items/new' do
        if logged_in?
            @user = User.find(session[:user_id])
            @whiskeys = Whiskey.all
            erb :'items/new'
        else
            redirect '/login'
        end
        
    end

    post '/items' do

        if logged_in?
            if !params[:item][:last_tasted_date].empty? && params[:item][:last_tasted_date].match?(/^(\d{4}-\d{2}-\d{2})/) #Validates last_tasted_date
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
        else
            redirect '/login'
        end
    end

    get '/items/:id' do
        if logged_in?
            @item = Item.find(params[:id])
            @user = current_user
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
        if logged_in?
            @item = Item.find(params[:id])
            @user = current_user
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
        if logged_in?
            item = Item.find(params[:id])
            user = current_user
            if item.user == user
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

    post '/items/:id/delete' do
        if logged_in?
            item = Item.find(params[:id])
            user = current_user
            if item.user == user
                item.destroy
            end
            redirect '/items'
        else
            redirect '/login'
        end
    end

end
