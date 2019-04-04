module ApplicationHelper
    def is_logged_in?
        session[:username]!=nil
    end

    def current_user 
        if is_logged_in?
           user= User.find_by(username:session[:username])
        #    puts User.all.inspect
        end 
    end

    def lesson_completed(lesson)
        puts current_user.inspect
        user_lesson= UserLesson.find_by(lesson_id:lesson.id,user_id:current_user.id)
        if user_lesson 
            user_lesson.completed
        else 
            false
        end
    end
end
