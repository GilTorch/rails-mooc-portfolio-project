class Course < ApplicationRecord
    validates :title,presence: true, uniqueness: true
    has_many :user_courses 
    has_many :users, through: :user_courses 
    has_many :chapters
end
