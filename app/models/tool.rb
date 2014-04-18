class Tool < ActiveRecord::Base
  attr_accessible :name, :quantity, :trademark, :price_unitary

 has_many :booking_tools
 has_many :bookings, :through => :booking_tools

 ######## Validaciones ########
 validates_presence_of :name, :message => "Ingrese un nombre de un instrumento o accesorio"
 validates_numericality_of :quantity, :on => :create, :message => "Ingrese la cantidad de instrumentos o accesorios disponibles"
 validates_presence_of :trademark, :message => "Ingrese la marca a cual pertenece el instrumento o accesorio"
 validates_numericality_of :price_unitary, :on => :create, :message => "Ingrese el precio unitario del instrumento o accesorio"
end
