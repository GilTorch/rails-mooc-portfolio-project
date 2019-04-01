module ApplicationHelper
    def is_logged_in?
        session[:username]!=nil
    end

    def current_user 
        User.find_by(username:session[:username])
    end
end
