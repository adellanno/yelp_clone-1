class Review < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :user

  validates :restaurant_id, presence: true
  validates :user_id, presence: true
  validates :rating, inclusion: (1..5)

end
