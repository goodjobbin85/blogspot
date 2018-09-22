class Category < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :name, length: { maximum: 20 }
	has_many :article_categories
	has_many :articles, through: :article_categories, dependent: :destroy
end
