class StyleGroup < ActiveRecord::Base
  attr_accessible :group_id, :music_style_id

  belongs_to :group
  belongs_to :music_style

 end
