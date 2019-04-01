class UsersController < ApplicationController
    def new 
        @user=User.new
    end

    def create 
        @user=User.new(user_params)
        if @user.save
            redirect_to "/login"
        else 
            redirect_to "/users/new"
        end
    end


    def user_params
        params.require(:user).permit(:username,:email,:password,:password_confirmation)
    end



end
