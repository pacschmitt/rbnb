class Gear < ApplicationRecord
  include PgSearch::Model
  CATEGORIES = %w[Cycling Outdoors Racket-Sports Team-Sports Winter-Sports Water-Sports Exercice Golf Precision-Sports Skates&Skateboards]

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address

  # multisearchable against: [ :name, :description, :address ]

  # pg_search_scope :global_search,
  #   against: [ :name, :description, :address ],
  #   associated_against: {
  #     user: [ :first_name, :last_name ]
  #   },
  #   using: {
  #     tsearch: { prefix: true }
  #   }

  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, presence: true
end
