class Admin::LessonsController < AdminController
    before_action :init
    before_action :set_lesson,only:[:show,:edit,:update,:destroy,:validate] 

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
        if @lesson.is_a_lab 
            user_lessons=UserLesson.where("lesson_id = ?",@lesson)
            @lesson_solutions_from_all_users=[]
            user_lessons.each do |user_lesson|
                user_solution=UserSolution.where("user_lesson_id = ?",user_lesson.id)
                @lesson_solutions_from_all_users.push(user_solution)
                puts @lesson_solutions_from_all_users.inspect
                @solutions=@lesson_solutions_from_all_users.flatten
            end

            # @lesson_solutions_from_all_users=UserSolution.where("user_lesson_id = ?",@lesson.id);
        end
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

    def validate 
        user_lesson = UserLesson.find_by(user_id:current_user.id,lesson_id:@lesson.id)
        if user_lesson 
           user_solution=UserSolution.find_by(user_lesson_id:user_lesson.id)
           if user_solution 
                if user_solution.content!=""
                    user_solution.validated=true 
                    user_solution.save 
                    complete_lesson(@lesson)
                end
           end
        end
        redirect_to admin_lesson_path(@lesson)
    end

    def lesson_params 
        params.require(:lesson).permit(:title,:content,:is_a_lab)
    end

end 