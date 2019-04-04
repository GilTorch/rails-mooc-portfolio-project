class CoursesController < ApplicationController
    def new 
        @course=Course.new
    end

    def index
        @courses=Course.all
    end

    def edit 
        @course=Course.find_by(id:params[:id])
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
        @course=Course.find_by(id:params[:id])
        @course.update(course_params)
        redirect_to course_path(@course)
    end

    def reset
        course=Course.find_by(id:params[:id])
        if course
            reset_course(course)
            redirect_to course_path(course)
        else
            redirect_to root_path 
        end
    end


    def show 
        @course=Course.find_by(id:params[:id])
    end

    def destroy
        course=Course.find_by(id:params[:id])
        course.destroy 
        redirect_to courses_path
    end

    def course_params
        params.require(:course).permit(:title)
    end
end
