class CoursesController < ApplicationController
    before_action :require_login 
    before_action :set_course,only:[:edit,:show,:update,:reset]

    
    def new 
        @course=Course.new
    end

    def index
        @courses=Course.all
    end

    def edit 
    end

    def create
        course=Course.new(course_params)

        if course.save 
            redirect_to course_path(course)
        else 
            redirect_to root_path
        end
    end

    def update 
        @course.update(course_params)
        redirect_to course_path(@course)
    end

    def reset
        if @course
            reset_course(@course)
            redirect_to course_path(@course)
        else
            redirect_to root_path 
        end
    end


    def show 
    end

    def destroy
        course.destroy 
        redirect_to courses_path
    end

    def set_course
        @course=Course.find_by(id:params[:id])
    end

    def course_params
        params.require(:course).permit(:title)
    end
    
    def require_login
        redirect_to login_path unless session.include? :username
    end
end
