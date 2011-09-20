class Player < ActiveRecord::Base
  attr_accessible :map, :user, :name, :posx, :posy, :map_id, :user_id, :description
  
  validates :description, :length => { :maximum => 250 }
  belongs_to :map
  belongs_to :user
end
