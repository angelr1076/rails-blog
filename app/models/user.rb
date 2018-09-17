class User < ApplicationRecord
    has_many :posts
    has_many :comments

    validates_presence_of :username, :password
    validates :username, presence: true, uniqueness: true
    validates :username, length: {minimum: 4, maximum: 30}
    validates :password, length: {minimum: 4, maximum: 20}
end
