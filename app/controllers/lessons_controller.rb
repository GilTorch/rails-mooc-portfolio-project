class LessonsController < ApplicationController
    before_action :require_login 
    before_action :set_lesson,only:[:edit,:show,:update,:reset,:validate,:complete]

    def index
        @lessons=Lesson.all
    end

    def new 
        @chapters=Chapter.all
        @lesson=Lesson.new
    end

    def create
        puts lesson_params.inspect
        lesson=Lesson.new(lesson_params)
        lesson.chapter=Chapter.find_by(id:params[:chapter_id])
        if lesson.save 
            redirect_to lesson_path(lesson)
        else 
            redirect_to root_path
        end
    end

    def complete 
        
        complete_lesson(@lesson)
        redirect_to lesson_path(@lesson)
    end

    def reset 
        reset_lesson(@lesson)
        redirect_to lesson_path(@lesson)
    end


    def edit
        @chapters=Chapter.all
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
        redirect_to lesson_path(@lesson)
    end

    def update 
        @lesson.chapter=Chapter.find_by(id:params[:chapter_id])
       
        if @lesson.update(lesson_params)
            redirect_to lesson_path(@lesson) 
        else 
            redirect_to root_path
        end
 
    end


    def destroy
        lesson=Lesson.find_by(id:params[:id])
        lesson.destroy 
        redirect_to lessons_path
    end


    def show 
        @chapter=@lesson.chapter
    end

    def set_lesson 
        @lesson=Lesson.find_by(id:params[:id])
    end


    def lesson_params 
        params.require(:lesson).permit(:title,:content,:is_a_lab)
    end

    def require_login
        redirect_to login_path unless session.include? :username
    end
end
