class Chapter < ApplicationRecord
    validates :title,presence: true
    has_many :user_chapters 
    has_many :users, through: :user_chapters 
    belongs_to :course
    has_many :lessons
end
