class Room < ApplicationRecord
  belongs_to :user
  
  has_many :reverses_of_post, class_name: 'Post', foreign_key: 'room_id'
  has_many :posteds, through: :reverses_of_post, source: :user
  
  
  has_many :favorites, class_name: 'Favorite', foreign_key: 'room_id'
  
  validates :name, presence: true, length: { maximum: 25 }
  validates :introduction, presence: true, length: { maximum: 30 }
end
