require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions #enables session hash in cookies
    set :session_secret, "$3kR*Tk3y5"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user(session_hash)
      User.find(session_hash[:user_id])
    end

    def logged_in?(session_hash)
        !!session_hash[:user_id]
    end

    def log_in(user)
        session[:user_id] = user.id 
    end
  end
end
