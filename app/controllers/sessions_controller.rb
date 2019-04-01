class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token  

    def create
        if auth
            @user = User.find_or_create_by(id: auth['uid']) do |u|
                u.username = auth['info']['name']
                u.email = auth['info']['email']
                # u.image = auth['info']['image']
              end
              session[:username]=@user.username 
              redirect_to "/"
        else
            user=User.find_by(username:params[:username])
            if user && user.authenticate(params[:password])
            session[:username]=user.username 
            redirect_to "/"
            end
        end
    end 

    def facebook_auth 
        puts params.inspect
    end

    def new 
    end 

    def destroy 
      if session.key?("username")
        session.delete :username
        redirect_to "/"
      end
    end

    private 
        def auth 
            request.env["omniauth.auth"]
        end
end