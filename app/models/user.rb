class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	has_many :comments, dependent: :destroy
	validates :name, presence: true
	validates :name, length: { minimum: 4, maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 }, 
	          uniqueness: { case_sensitive: false },
	          format: { with: VALID_EMAIL_REGEX }
	          
	has_secure_password
end
