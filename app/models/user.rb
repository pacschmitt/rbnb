class User < ApplicationRecord
  include PgSearch::Model
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings, dependent: :destroy
  has_many :gears, dependent: :destroy
  has_one_attached :photo

  multisearchable against: [ :first_name, :last_name ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :email, presence: true, uniqueness: true
end
