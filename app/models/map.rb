class Map < ActiveRecord::Base
  
  attr_accessible :name
  
  validates :name, :presence => true, :uniqueness => true
  
  has_many :players
  
  def get_players(centreX, centreY, zone = 5)
    
    @positions = Hash.new
    #Get all player in a specified area of the current map
    self.players.where("posx BETWEEN ? and ? 
                        AND posy BETWEEN ? and ?",
                        centreX-zone, centreX+zone,
                        centreY-zone, centreY+zone).each do |player|
    
      @positions["#{player.posx};#{player.posy}"] = player
     end
     @positions
  end
  
end
