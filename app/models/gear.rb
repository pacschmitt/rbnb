class Gear < ApplicationRecord
  CATEGORIES = %w[Cycling Outdoors Racket-Sports Team-Sports Winter-Sports Dance Exercice Golf Precision-Sports Skates&Skateboards]
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
end
