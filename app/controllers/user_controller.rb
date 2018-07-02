class UserController < ApplicationController
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @session = session
        erb :'users/home'
    end
end