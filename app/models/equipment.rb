class Equipment < ActiveRecord::Base
  attr_accessible :quantity, :tool, :trademark
  belongs_to :room

  ######## Validaciones ########
 validates_presence_of :tool, :message => "Ingrese un nombre del equipo"
 validates_presence_of :trademark, :message => "Ingrese la marca del equipo"
 validates_numericality_of :quantity, :on => :create, :message => "Ingrese la cantidad del equipo que esta ingresando"
 
end
