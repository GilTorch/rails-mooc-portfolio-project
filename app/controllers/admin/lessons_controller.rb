class Admin::LessonsController < AdminController
    before_action :init
    before_action :set_lesson,only:[:show,:edit,:update,:destroy] 

    def init 
        @lessons=Lesson.all
        @courses=Course.all
        @chapters=Chapter.all
    end

    def index 
        @lessons=Lesson.all
        @lesson=Lesson.new 
        @chapters=Chapter.all
    end

    def show 
        render "admin/lessons/show"
    end

    def create 
        @lesson=Lesson.new(lesson_params)
        @lesson.chapter = Chapter.find_by(id:params[:chapter_id])
        if @lesson.save 
            flash[:success]="Lesson was successfully created."
        end

        
        render "admin/lessons/index"
    end

    def edit 
        render "admin/lessons/edit"
    end

    
    def update
        @lesson.chapter=Chapter.find_by(id:params[:chapter_id])
        if @lesson.update(lesson_params)
            flash[:success] = "Lesson was successfully updated."    
        else  
            flash[:danger] = "Something unexpected happened. Please try again"
        end
        render "admin/lessons/index"
    end

    def destroy
        if @lesson.destroy 
            flash[:success]="Lesson was successfully destroyed"
        else
            flash[:danger]="Something unexpected happened. Please try again"
        end
        redirect_to admin_lessons_path
    end

    def set_lesson
        @lesson=Lesson.find_by(id:params[:id])
        @chapter=@lesson.chapter

        if @chapter == nil 
            @course=nil 
        else 
            @course=@chapter.course 
        end
        
        @lessons=Lesson.all
    end

    def lesson_params 
        params.require(:lesson).permit(:title,:content,:is_a_lab)
    end

end 