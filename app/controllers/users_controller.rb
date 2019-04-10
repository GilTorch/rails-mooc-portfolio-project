class UsersController < ApplicationController
    def new 
        @user=User.new
    end

    def edit 
        @user=User.find_by(id:params[:id])
    end

    def create 
        @user=User.new(user_params)
        if @user.save
            session[:username]=@user.username
            redirect_to user_path(@user)
        else 
            render 'users/new'
        end
    end

    def update
        @user=User.find_by(id:params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user) 
        else 
            redirect_to root_path
        end
    end
    
    def show
        @user=User.find_by(id:params[:id])
        if !@user 
            redirect_to root_path
        end
    end

    def destroy
        user=User.find_by(id:params[:id])
        user.destroy 
    end


    def user_params
        params.require(:user).permit(:username,:email,:password,:password_confirmation)
    end

end
