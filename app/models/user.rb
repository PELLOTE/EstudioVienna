class User < ActiveRecord::Base
  attr_accessible  :apellidos, :email, :password, :password_confirmation, :user_type_id, :name, :lastname, :surname, :instrument, :fono, :old_password
  authenticates_with_sorcery!  

  has_many :bookings
  belongs_to :user_type
  has_many :groups

  ######## Validaciones ########
  validates_confirmation_of :password, :message => 'Tiene que confirmar la password'
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create, :message => "Ingrese su correo electronico"
  validates_uniqueness_of :email, :message => "El correo que ha ingresado ya ha sido ocupado por otro usuario"
  
  validates_presence_of :name, :message => "Ingrese su nombre"
  validates_presence_of :lastname, :message => "Ingrese su apellido paterno"
  #validates_presence_of :surname, :message => "Ingrese su apellido Materno"
  #validates_presence_of :instrument, :message => "Ingrese el instrumento que toca"
  validates_presence_of :fono, :message => "Ingrese su numero de telefono"
end