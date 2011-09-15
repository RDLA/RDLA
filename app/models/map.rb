class Map < ActiveRecord::Base
  
  attr_accessible :name, :default_field_id
  
  validates :name, :presence => true, :uniqueness => true
  
  has_many :players
  
  belongs_to :default_field, :class_name => 'Field'
  validates :default_field, :presence => true
  
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
  def get_fields(centreX, centreY, zone = 5)
    # TODO: Get all fields in a specified area of the current map

  end
  
  
  
end
