class Room < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 25 }
  validates :introduction, presence: true, length: { maximum: 30 }
end
