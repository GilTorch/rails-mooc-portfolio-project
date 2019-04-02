class UsersController < ApplicationController
    def new 
        @user=User.new
    end

    def create 
        @user=User.new(user_params)
        if @user.save
            session[:username]=@user.username
            redirect_to user_path(@user)
        else 
            redirect_to "/users/new"
        end
    end
    
    def show
        @user=User.find_by(id:params[:id])
        if !@user 
            redirect_to "/"
        end
    end


    def user_params
        params.require(:user).permit(:username,:email,:password,:password_confirmation)
    end

end
