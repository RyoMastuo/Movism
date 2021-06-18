class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :rooms
  
  has_many :posts
  has_many :postings, through: :posts, source: :room
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :room
  
  def post(other_room)
    self.posts.find_or_create_by(room_id: other_room.id)
  end
  
  def posting?(other_room)
    self.postings.include?(other_room)
  end
  
  def favorite(other_room)
    self.favorites.find_or_create_by(room_id: other_room.id)
  end
  
  def unfavorite(other_room)
    favorite = self.favorites.find_by(room_id: other_room.id)
    favorite.destroy if favorite
  end
  
  def favoriting?(other_room)
    self.likes.include?(other_room)
  end
  
  
end
