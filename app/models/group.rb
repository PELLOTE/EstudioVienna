class Group < ActiveRecord::Base
  attr_accessible :name, :music_style_ids
  has_many :style_groups
  has_many :members
  has_many :music_styles, :through => :style_groups
  belongs_to :user

######## Validaciones ########
 validates_presence_of :name, :message => "Ingrese un nombre de grupo ej. Metallica"
 validates_presence_of :music_style_ids, :message => "A que estilo musical pertenece ej. Rock, Metal"
 validates_uniqueness_of :name, :message => "El nombre del grupo ingresado ya existe"



def self.search(search)
	encontrar = find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  if encontrar.blank?
    Group.find(:all, :joins => :music_styles, :conditions =>['music_styles.name LIKE ?', "%#{search}%"])
  elsif encontrar
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end


end
