class Admin::UsersController < AdminController
    before_action :set_user,only:[:show,:edit,:update] 

    def index 
        @users=User.all
        @user=User.new
    end

    def show 
        render "admin/users/show"
    end

    def create 
        @user=User.new(user_params)
        @users=User.all
        if @user.save 
            flash[:success]="User was successfully created."
        end
        render "admin/users/index"
    end

    def edit 
        render "admin/users/edit"
    end

    
    def update
        if @user.update(user_params)
            flash[:success] = "User was successfully updated."    
        else  
            flash[:danger] = "Something unexpected happened. Please try again"
        end
        render "admin/users/index"
    end

    def destroy
        user=User.find_by(id:params[:id])
        if user.destroy 
            flash[:success]="User was successfully destroyed"
        else
            flash[:danger]="Something unexpected happened. Please try again"
        end
        redirect_to admin_users_path
    end

    def set_user 
        @user=User.find_by(id:params[:id])
        @users=User.all
    end

    def user_params
        params.require(:user).permit(:username,:email,:password,:password_confirmation)
    end

end