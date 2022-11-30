class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :gear

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :no_booking_overlap

  scope :overlapping, ->(start_date, end_date) do
    where "((start_date <= ?) and (end_date >= ?))", end_date, start_date
  end

  private

  def no_booking_overlap
    if Booking.overlapping(start_date, end_date).any?
      errors.add(:end_date, 'it overlaps another reservation')
    end
  end
end
