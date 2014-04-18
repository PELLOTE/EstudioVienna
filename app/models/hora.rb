class Hora < ActiveRecord::Base
  attr_accessible :endTime, :name, :startTime

  	has_many :booking_times
	has_many :bookings, :through => :booking_times

	######## Validaciones ########
 validates_presence_of :name, :message => "Ingrese un nombre ej. de 11:00 a 12:00"
 validates_numericality_of :startTime, :on => :create, :message => "Indique a que hora empieza ej. 11"
 validates_numericality_of :endTime, :on => :create, :message => "Indique a que hora termina ej. 12"
end

