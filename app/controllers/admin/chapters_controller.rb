class Admin::ChaptersController < AdminController
    before_action :set_chapter,only:[:show,:edit,:update,:destroy] 

    def index 
        @chapters=Chapter.all
        @chapter=Chapter.new
        @courses=Course.all
    end

    def show 
        render "admin/chapters/show"
    end

    def create 
        puts params.inspect
        @chapter=Chapter.new(chapter_params)
        @chapter.course=Course.find_by(id:params[:course_id])
        @chapters=Chapter.all
        @courses=Course.all
        if @chapter.save 
            flash[:success]="Chapter was successfully created."
        end
        render "admin/chapters/index"
    end

    def edit 
        render "admin/chapters/edit"
    end

    
    def update
        if @chapter.update(chapter_params)
            flash[:success] = "Chapter was successfully updated."    
        else  
            flash[:danger] = "Something unexpected happened. Please try again"
        end
        render "admin/chapters/index"
    end

    def destroy
        if @chapter.destroy 
            flash[:success]="Chapter was successfully destroyed"
        else
            flash[:danger]="Something unexpected happened. Please try again"
        end
        redirect_to admin_chapters_path
    end

    def set_chapter
        @chapter=Chapter.find_by(id:params[:id])
        @chapters=Chapter.all
        @courses=Course.all
    end

    def chapter_params
        params.require(:chapter).permit(:title)
    end

end 