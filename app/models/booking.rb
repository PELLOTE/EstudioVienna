class Booking < ActiveRecord::Base
  	attr_accessible :amount, :estate, :fecha, :room_id, :hora_ids, :tool_ids

  	has_many :assistants
	has_many :booking_times
	has_many :booking_tools
	has_many :horas, :through => :booking_times
	has_many :tools, :through => :booking_tools
	belongs_to :room
	belongs_to :user

	######## Validaciones ########
 #validates_presence_of :hora_ids, :message => "Ingrese la hora que desea reservar"	
 #validates_presence_of :room_id, :message => "Ingrese la sala que desera reservar"	
	def self.emailrecuerda
		booki = Booking.find(:all , :conditions => {:estate => "Solicitado"} )
		booki.each do |booking|
			id = booking.user_id 
			@user = User.find(id)
		 	date =	booking.fecha - 1.day
				 if date == Date.today
				 	UserMailer.recuerdaEmail(@user, booking).deliver
				 end
		end
	end	
  
end