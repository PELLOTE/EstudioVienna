class BookingTool < ActiveRecord::Base
  
  attr_accessible :booking_id, :tool_id
  belongs_to :tool
  belongs_to :booking
end
