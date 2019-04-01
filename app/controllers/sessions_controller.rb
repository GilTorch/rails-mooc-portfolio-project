class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token  

    def create
       user=User.find_by(username:params[:username])
       if user && user.authenticate(params[:password])
        session[:username]=user.username 
        redirect_to "/login"
       end
    end 

    def new 
    end 

    def destroy 
    end
end