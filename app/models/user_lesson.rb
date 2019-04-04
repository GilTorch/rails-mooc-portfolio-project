class UserLesson < ApplicationRecord
    belongs_to :user 
    belongs_to :lesson
    has_many :user_solutions
end
