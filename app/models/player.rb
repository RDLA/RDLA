class Player < ActiveRecord::Base
  attr_accessible :map, :user, :name, :posx, :posy, :map_id, :user_id
  
  belongs_to :map
  belongs_to :user
end
