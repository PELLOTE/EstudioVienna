class Assistant < ActiveRecord::Base
  attr_accessible :instrument, :lastname, :name, :nickname, :surname

  belongs_to :booking

  ######## Validaciones ########
 validates_presence_of :name, :message => "Ingrese el nombre de asistente"
 validates_presence_of :lastname, :message => "Ingrese el apellido de asistente"
 validates_presence_of :nickname, :message => "Ingrese un apodo del asistente"
 validates_presence_of :instrument, :message => "Ingresa el instrumento que toca"

end
