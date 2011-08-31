class Player < ActiveRecord::Base
  attr_accessible :map, :user, :name, :posx, :posy
  
  belongs_to :map
  belongs_to :user
end
