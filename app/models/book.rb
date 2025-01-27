class Book < ApplicationRecord
  belongs_to :shelf, optional: true
  belongs_to :user
  has_one_attached :image
  validates :name, :author, :about, presence: true
end
