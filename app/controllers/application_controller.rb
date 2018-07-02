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

end
