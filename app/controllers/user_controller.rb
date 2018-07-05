class UserController < ApplicationController
    
    get '/users/:slug' do
        if logged_in?
            if @user = User.find_by_slug(params[:slug])
                @items = @user.items
                erb :'items/home'
            else
                redirect '/items'
            end
        else
            redirect '/login'
        end
    end

    get '/signup' do
        if logged_in?
            redirect "/users/#{User.find(session[:user_id]).slug}"
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        if params[:user].all? {|k,v| !v.empty?}
            params[:user][:username].downcase!
            #redirect user if desired username is already taken
            if User.find_by(username: params[:user][:username])
                flash[:user_taken] = "Username is not available."
                redirect '/signup'
            else
                user = User.create(params[:user])
                session[:user_id] = user.id 
                redirect "/users/#{user.slug}"
            end
        else
            flash[:err_all_fields] = "Please fill out all fields"
            redirect '/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect "/users/#{User.find(session[:user_id]).slug}"
        else
            erb :'users/login'
        end
    end

    post '/login' do
        if params[:user].all? {|k,v| !v.empty?}
            user = User.find_by(username: params[:user][:username].downcase)
            if user && user.authenticate(params[:user][:password])
                log_in(user)
                redirect "/items"
            else
                flash[:wrong_credentials] = "Incorrect Username and/or Password"
                redirect '/login'
            end
        else
            flash[:err_all_fields] = "Please fill out all fields"
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end