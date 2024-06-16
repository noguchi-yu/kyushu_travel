class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 300 }
  validates :address, presence: true, uniqueness: true
end
