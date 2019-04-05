class UserSolution < ApplicationRecord 
    validates :content,presence: true
    belongs_to :user_lesson
end