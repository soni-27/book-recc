class Book < ApplicationRecord
  belongs_to :shelf
  belongs_to :user
end
