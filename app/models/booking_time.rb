class BookingTime < ActiveRecord::Base
  attr_accessible :booking_id, :hora_id

  belongs_to :hora
  belongs_to :booking
end
