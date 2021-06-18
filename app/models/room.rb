class Room < ApplicationRecord
  belongs_to :user
  
  has_many :posts
  has_many :room_postings, through: :posts, source: :user
  
  
  has_many :favorites, class_name: 'Favorite', foreign_key: 'room_id'
  
  validates :name, presence: true, length: { maximum: 25 }
  validates :introduction, length: { maximum: 30 }
end
