class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token  


    def create
        if auth
            
            user = User.find_or_create_by(id: auth['uid']) do |u|
                u.username = auth['info']['name']
                u.email = auth['info']['email']
                real_password="password"
                salt="my_salt"
                sha1_password=Digest::SHA1.hexdigest("#{salt}#{real_password}")
                u.password_digest=BCrypt::Password.create(sha1_password).to_s
                # u.image = auth['info']['image']
              end
              session[:username]=user.username 
              redirect_to user_path(user)
        else
            user=User.find_by(username:params[:username])

            if user && user.authenticate(params[:password])
                session[:username]=user.username 
                redirect_to user_path(user)
            else 
                redirect_to root_path
            end
        end
    end 


    def new 
        if is_logged_in?
            redirect_to user_path(current_user.id)
        end
    end
    

    def destroy 
      if is_logged_in?
        session.delete :username
        redirect_to "/"
      end
    end

    private 
        def auth 
            puts "AUTH:"+request.env["omniauth.auth"].inspect
            request.env["omniauth.auth"]
        end

        def is_logged_in?
            session[:username]!=nil
        end
    
        def current_user 
            User.find_by(username:session[:username])
        end
end