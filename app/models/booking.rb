class Booking < ApplicationRecord
  belongs_to :user
  belong_to :gear

  validates :start_date, presence: true
  validates :end_date, presence: true
end
