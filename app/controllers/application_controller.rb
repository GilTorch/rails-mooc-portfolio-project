class ApplicationController < ActionController::Base
    def home 
    end
    def is_logged_in?
        session[:username]!=nil
    end

    def current_user 
        if is_logged_in?
           user= User.find_by(username:session[:username])
        #    puts User.all.inspect
        end 
    end

end
