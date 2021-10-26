class User < ApplicationRecord
    has_secure_password
    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy

    validates :name, presence: true
    has_many :likes, dependent: :destroy
    has_many :liked_ideas, through: :likes, source: :idea
end
