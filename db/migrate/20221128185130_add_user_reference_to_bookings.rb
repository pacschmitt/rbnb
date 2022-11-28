class AddUserReferenceToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :gear
  end
end
