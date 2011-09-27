class Player < ActiveRecord::Base
  attr_accessible :map, :user, :name, :posx, :posy, :map_id, :user_id, :description,
    :power, :power_max
  
  belongs_to :map
  belongs_to :user
  
  validates :description, :length => { :maximum => 250 }
  validates :power, :presence => true, :numericality => true, :if => :lower_than_power_max?
  validates :power_max, :presence => true, :numericality => true, :if => :lower_than_power_max?
  def lower_than_power_max?
    
    self.power <= self.power_max
  end
  
  
end
