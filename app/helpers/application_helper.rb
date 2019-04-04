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
        user_lesson= UserLesson.find_by(lesson_id:lesson.id,user_id:current_user.id)
        if user_lesson 
            user_lesson.completed
        else 
            false
        end
    end

    def reset_lesson(lesson)
        user_lesson=UserLesson.find_by(lesson_id:lesson.id,user_id:current_user.id)
        if user_lesson 
            user_lesson.completed=false
            user_lesson.save
        end
    end

    def reset_chapter(chapter)
        if current_user 
            user_chapter=UserChapter.find_or_create_by(chapter_id:chapter.id,user_id:current_user.id)
            if !chapter.lessons.empty?
                user_chapter.completed=false
                user_chapter.save
                chapter.lessons.each do |lesson|
                    reset_lesson(lesson)
                end
            end
        end
    end

    def chapter_completed(chapter)
        user_chapter=UserChapter.find_by(chapter_id:chapter.id,user_id:current_user.id)
        if !chapter.lessons.empty? && chapter.lessons.each do |lesson|
                user_lesson=UserLesson.find_or_create_by(lesson_id:lesson.id)
                if !user_lesson.completed
                    return false
                end
            end
        end
        return true
    end
end
