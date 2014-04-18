class Character < ActiveRecord::Base
  attr_accessible :address, :gmaps, :latitude, :longitude, :name
  acts_as_gmappable :process_geocoding => true

  	def gmaps4rails_address
	  address	
	end
	def gmaps4rails_sidebar
		address
	end
end
