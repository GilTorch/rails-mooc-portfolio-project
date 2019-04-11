module ApplicationHelper
    def is_logged_in?
        session[:username]!=nil
    end

    def is_admin?      
        if current_user==nil || current_user.admin==false 
         return false 
        end
        return true
     end

    def is_admin_redirect?      
        if current_user==nil || current_user.admin==false 
         redirect_to root_path
        end
     end

    def current_user 
        if is_logged_in?
           user= User.find_by(username:session[:username])
           return user
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
    
    def complete_lesson(lesson)
        user_lesson=UserLesson.find_or_create_by(user_id:current_user.id,lesson_id:@lesson.id)
        user_lesson.completed=true 
        user_lesson.save
    end


    def reset_lesson(lesson)
        user_lesson=UserLesson.find_by(lesson_id:lesson.id,user_id:current_user.id)
        
        if lesson.is_a_lab
            user_solution=UserSolution.find_by(user_lesson_id:user_lesson.id)
            if user_solution 
                user_solution.validated=false
                user_solution.save
            end
        end

        if user_lesson 
            user_lesson.completed=false
            user_lesson.save
        end
    end


    def all_lessons_completed 
       if current_user
       user_lessons= UserLesson.where("user_id = ? AND completed = ? ",current_user.id,true)
       user_lessons.count
       end
    end

    def all_courses_completed 
        if current_user
        user_courses= UserCourse.where("user_id = ? AND completed = ? ",current_user.id,true)
        puts user_courses.inspect
        user_courses.count
        end
    end


    def all_chapters_completed 
        if current_user
            puts "CURRENT USER ID IN RESET CHAPTER METHOD: #{current_user.id}"
        user_chapters= UserChapter.where("user_id = ? AND completed = ? ",current_user.id,true)
        user_chapters.count
        end
    end

    def course_completed(course)
        user_course=UserCourse.find_or_create_by(course_id:course.id,user_id:current_user.id)
        if user_course && !course.chapters.empty?
            course.chapters.each do |chapter|
                if !chapter_completed(chapter)
                    return false 
                end
            end
        end
        return true
    end

    def reset_course(course)
        if current_user 
            user_course=UserCourse.find_or_create_by(course_id:course.id,user_id:current_user.id)
            if !course.chapters.empty?
                user_course.completed=false
                user_course.save
                course.chapters.each do |chapter|
                    reset_chapter(chapter)
                end
            end
        end
    end

    def chapter_completed(chapter)
        user_chapter=UserChapter.find_or_create_by(chapter_id:chapter.id,user_id:current_user.id)
        if !chapter.lessons.empty? 
            chapter.lessons.each do |lesson|
                if !lesson_completed(lesson)
                    return false
                end
            end
        end
        return true
    end

    def complete_fail_icon(ressource,type)
        complete_icon="fa fa-check-circle green"
        fail_icon="fa fa-circle red"
        case type 
            when "course"
                course_completed(ressource) ? complete_icon : fail_icon
            when "chapter"
                chapter_completed(ressource) ? complete_icon : fail_icon
            when "lesson"
                lesson_completed(ressource) ? complete_icon : fail_icon
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
            else 
                user_chapter.completed=false
                user_chapter.save
            end
        end
    end
end
