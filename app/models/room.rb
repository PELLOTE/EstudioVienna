class Room < ActiveRecord::Base
  attr_accessible :max, :price
  has_many :equipments
  has_many :bookings


  ######## Validaciones ########
  validates_numericality_of :max, :on => :create, :message => "Ingrese la capacidad maxima de personas ej. 8"
  validates_numericality_of :price, :on => :create, :message => "Ingrese el precio que cuesta por hora esta sala de ensayo ej. 3000"



  ####### funciones #########

  def full_name
    "#{id}, $#{price}, #{max} personas"
  end
  
end
