class UserSolutionsController < ApplicationController 
    skip_before_action :verify_authenticity_token  

    def create 
        @lesson=Lesson.find_by(params[:lesson_id])
        user_lesson = UserLesson.find_or_create_by(user_id:current_user.id,lesson_id:params[:lesson_id])
        if user_lesson 
           user_solution=UserSolution.find_by(user_lesson_id:user_lesson.id)
           puts user_solution.inspect
           if user_solution 
                user_solution.update(content:params[:solution])
           else 
                user_solution= UserSolution.create(content:params[:solution],user_lesson_id:user_lesson.id)
           end
        else 
        redirect_to lesson_path(@lesson)
        end
    end
    
end