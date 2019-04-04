class LessonsController < ApplicationController
    def index
        @lessons=Lesson.all
    end

    def new 
        @chapters=Chapter.all
        @lesson=Lesson.new
        puts @lesson.inspect
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
        @lesson=Lesson.find_by(id:params[:id])
        user_lesson=UserLesson.find_or_create_by(user_id:current_user.id,lesson_id:@lesson.id)
        user_lesson.completed=true 
        user_lesson.save
        redirect_to lesson_path(@lesson)
    end

    def reset 
        @lesson=Lesson.find_by(id:params[:id])
        user_lesson=UserLesson.find_or_create_by(user_id:current_user.id,lesson_id:@lesson.id)
        user_lesson.completed=false 
        user_lesson.save
        redirect_to lesson_path(@lesson)
    end


    def edit
        @lesson=Lesson.find_by(id:params[:id])
        @chapters=Chapter.all
    end

    def update 
        puts params.inspect
        @lesson=Lesson.find_by(id:params[:id])
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
        @lesson=Lesson.find_by(id:params[:id])
        @chapter=@lesson.chapter
    end

    def lesson_params 
        params.require(:lesson).permit(:title,:content,:is_a_lab)
    end
end
