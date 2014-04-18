class Member < ActiveRecord::Base
  attr_accessible :group_id, :instrument, :lastname, :name, :surname
  belongs_to :group

  	######## Validaciones ########
 validates_presence_of :name, :message => "Ingrese un nombre"
 validates_presence_of :lastname, :message => "Ingrese un apellido paterno"
 validates_presence_of :surname, :message => "Ingrese un apellido materno"
 validates_presence_of :instrument, :message => "Ingrese el nombre del instrumento que toca"
end
