class Admin::CoursesController < AdminController
    before_action :set_course,only:[:show,:edit,:update,:destroy] 

    def index 
        @courses=Course.all
        @course=Course.new
    end

    def show 
        render "admin/courses/show"
    end

    def create 
        @course=Course.new(course_params)
        @courses=Course.all
        if @course.save 
            flash[:success]="Course was successfully created."
        end
        render "admin/courses/index"
    end

    def edit 
        render "admin/courses/edit"
    end

    
    def update
        if @course.update(course_params)
            flash[:success] = "Course was successfully updated."    
        else  
            flash[:danger] = "Something unexpected happened. Please try again"
        end
        render "admin/courses/index"
    end

    def destroy
        if @course.destroy 
            flash[:success]="Course was successfully destroyed"
        else
            flash[:danger]="Something unexpected happened. Please try again"
        end
        redirect_to admin_courses_path
    end

    def set_course
        @course=Course.find_by(id:params[:id])
        @courses=Course.all
    end

    def course_params
        params.require(:course).permit(:title)
    end

end 