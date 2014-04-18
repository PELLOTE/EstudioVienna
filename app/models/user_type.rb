class UserType < ActiveRecord::Base
  attr_accessible :name
  has_many :users

  ######## Validaciones ########
 validates_presence_of :name, :message => "Ingrese el nombre de rol de usuario ej. Musico"

end
