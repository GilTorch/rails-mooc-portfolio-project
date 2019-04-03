class LessonsController < ApplicationController
    def index
        @lessons=Lesson.all
    end

    def new 
        @chapters=Chapter.all
        @lesson=Lesson.new
    end

    def create
        lesson=Lesson.new(lesson_params)
        lesson.chapter=Chapter.find_by(id:params[:chapter_id])
        if lesson.save 
            redirect_to lesson_path(lesson)
        else 
            redirect_to root_path
        end
    end

    def edit
        @chapter=Chapter.find_by(id:params[:id])
        @courses=[@chapter.course]
    end

    def update 
        puts params.inspect
        @chapter=Chapter.find_by(id:params[:id])
        @chapter.course=Course.find_by(id:params[:course_id])
        puts @chapter.inspect
        if @chapter.update(chapter_params)
            redirect_to chapter_path(@chapter) 
        else 
            redirect_to root_path
        end
 
    end


    def destroy
        chapter=Chapter.find_by(id:params[:id])
        chapter.destroy 
        redirect_to chapters_path
    end


    def show 
        @lesson=Lesson.find_by(id:params[:id])
        @chapter=@lesson.chapter
    end

    def lesson_params 
        params.require(:lesson).permit(:title)
    end
end
