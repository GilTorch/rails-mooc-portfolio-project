class CoursesController < ApplicationController
    def new 
        @course=Course.new
    end

    def create
        course=Course.new(course_params)

        if course.save 
            redirect_to course_path(course)
        else 
            redirect_to root_path
        end
    end

    def show 
        @course=Course.find_by(id:params[:id])
    end


    def course_params
        params.require(:course).permit(:title)
    end
end
