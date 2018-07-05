class WhiskeyController <  ApplicationController

    get '/whiskeys' do
        if logged_in?
            @user = User.find(session[:user_id])
            @whiskeys = Whiskey.all.sort_by {|w| w.brand}
            erb :'/whiskeys/show'
        else
            redirect '/login'
        end
    end

end