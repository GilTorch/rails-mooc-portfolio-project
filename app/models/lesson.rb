class Lesson < ApplicationRecord
    has_many :user_lessons 
    has_many :users, through: :user_lessons 
    belongs_to :chapter
end
