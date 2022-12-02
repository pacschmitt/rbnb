class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :gear

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :no_booking_overlap

  private

  def no_booking_overlap
    gear_booking = []
    Booking.all.each do |booking|
      if booking.gear == gear
        gear_booking << booking
      end
    end
    gear_booking.each do |booking|
      if (start_date <= booking.end_date) && (end_date >= booking.start_date)
        errors.add(:end_date, 'it overlaps another reservation')
      end
    end
  end
end
