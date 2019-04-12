class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token  


    def create
        if auth
            puts auth.inspect
            user = User.find_or_create_by(id: auth['uid']) do |u|
                u.username = auth['info']['name']
                u.email = auth['info']['email']
                real_password="12345678"
                salt="my_salt"
                sha1_password=Digest::SHA1.hexdigest("#{salt}#{real_password}")
                u.password=BCrypt::Password.create(sha1_password).to_s
                # u.image = auth['info']['image']
              end
              session[:username]=user.username 
              puts "USER #{user.errors.inspect}"
              flash[:success]="Successfully logged in."
              redirect_to user_path(user)
        else
            user=User.find_by(username:params[:username])

            if user && user.authenticate(params[:password])
                session[:username]=user.username 
                flash[:success]="Successfully logged in."
                redirect_to user_path(user)
            else 
                flash[:danger]="There was an error while trying to connect you with your account. Check your credentials."
                redirect_to login_path
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