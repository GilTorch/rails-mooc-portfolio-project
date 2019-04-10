class ChaptersController < ApplicationController
    before_action :require_login 
    before_action :set_chapter,only:[:edit,:show,:update,:reset,:destroy]

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
        @courses=Course.all
    end

    def update 
        @chapter.course=Course.find_by(id:params[:course_id])
        puts @chapter.inspect
        if @chapter.update(chapter_params)
            redirect_to chapter_path(@chapter) 
        else 
            flash[:danger]="The chapter you are trying to "
            redirect_to root_path
        end
 
    end

    def reset
        chapter=Chapter.find_by(id:params[:id])
        if chapter
            reset_chapter(chapter)
            redirect_to chapter_path(chapter)
        else
            redirect_to root_path 
        end
    end

    def destroy
        @chapter.destroy 
        redirect_to chapters_path
    end


    def show 
    end

    def chapter_params 
        params.require(:chapter).permit(:title)
    end

    def set_chapter 
       @chapter=Chapter.find_by(id:params[:id])
    end

    def require_login
        redirect_to login_path unless session.include? :username
    end
end
