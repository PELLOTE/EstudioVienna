class MusicStyle < ActiveRecord::Base
  attr_accessible :name

  has_many :style_groups
  has_many :groups, :through => :style_groups

   ######## Validaciones ########
 validates_presence_of :name, :message => "Ingrese un nombre de estilo musical ej. Punk o Rock"
end
