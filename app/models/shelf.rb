class Shelf < ApplicationRecord
  belongs_to :user
  has_many :books, dependent: :destroy
  validates :title, presence: true
end
