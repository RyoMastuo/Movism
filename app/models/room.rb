class Room < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :introduction, presence: true, length: { maximum: 255 }
end
