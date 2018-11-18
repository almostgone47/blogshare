class Category < ApplicationRecord
  validates :category_name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  has_many :article_categories
  has_many :articles, through: :article_categories
end