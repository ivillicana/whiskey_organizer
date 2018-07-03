class UserController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @session = session
        erb :'users/home'
    end

    get '/signup' do
        if Helper.logged_in?(session)
            redirect "/users/#{User.find(session[:user_id]).slug}"
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        if params[:user].all? {|k,v| !k.empty?}
            user = User.create(params[:user])
            session[:user_id] = user.id 
            redirect "/users/#{user.slug}"
        else
            redirect '/signup'
        end
    end

    get '/login' do
        binding.pry
        if Helper.logged_in?(session)
            redirect "/users/#{User.find(session[:user_id]).slug}"
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect "/users/#{user.slug}"
        else
            redirect '/login'
        end
    end

end