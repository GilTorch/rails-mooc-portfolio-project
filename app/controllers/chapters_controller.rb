class ChaptersController < ApplicationController
    def index
        @chapters=Chapter.all
    end

    def new 
        @courses=Course.all
        @chapter=Chapter.new
    end

    def create
        chapter=Chapter.new(chapter_params)
        chapter.course=Course.find_by(id:params[:course_id])
        if chapter.save 
            redirect_to chapter_path(chapter)
        else 
            redirect_to root_path
        end
    end

    def edit
        @chapter=Chapter.find_by(id:params[:id])
        @courses=Course.all
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
        @chapter=Chapter.find_by(id:params[:id])
    end

    def chapter_params 
        params.require(:chapter).permit(:title)
    end
end
