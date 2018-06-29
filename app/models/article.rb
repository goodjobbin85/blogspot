class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true, 
  			length: { minimum: 5, maximum: 150 }
end
