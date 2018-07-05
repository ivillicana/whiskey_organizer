class UserController < ApplicationController
    
    get '/users/:slug' do
        if logged_in?
            if @user = User.find_by_slug(params[:slug])
                @items = @user.items
                erb :'items/home'
            else
                redirect '/items' #if cannot find username slug
            end
        else
            redirect '/login' #if not logged in
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
        if user_params_filled? #checks if all form field are filled
            params[:user][:username].downcase!
            #redirect user if desired username is already taken
            if User.find_by(username: params[:user][:username])
                flash[:user_taken] = "Username is not available."
                redirect '/signup'
            else #create user if all fields are correctly filled
                user = User.create(params[:user])
                session[:user_id] = user.id 
                redirect "/users/#{user.slug}"
            end
        else #if fields are not filled out
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