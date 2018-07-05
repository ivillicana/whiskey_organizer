require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  
  configure do
    enable :sessions #enables session hash in cookies
    set :session_secret, "$3kR*Tk3y5"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if logged_in?
      redirect '/items'
    else
      erb :index
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
        !!session[:user_id]
    end

    def log_in(user)
        session[:user_id] = user.id 
    end

    def valid_date? #checks if date field is correctly fille out
      !params[:item][:last_tasted_date].empty? && params[:item][:last_tasted_date].match?(/^(\d{4}-\d{2}-\d{2})/)
    end

    def user_params_filled? #checks if all form fields are filled for sign up/ log in
      params[:user].all? {|k,v| !v.empty?}
    end

  end

end
