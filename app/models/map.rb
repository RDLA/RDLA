class Map < ActiveRecord::Base
  
  attr_accessible :name, :default_field_id
  
  validates :name, :presence => true, :uniqueness => true
  
  has_many :players
  has_many :buildings
  has_many :terraformings
  
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
    @fields = Hash.new
      self.terraformings.where("posx BETWEEN ? and ? 
                        AND posy BETWEEN ? and ?",
                        centreX-zone, centreX+zone,
                        centreY-zone, centreY+zone).each do |field|
    
      @fields["#{field.posx};#{field.posy}"] = field
     end
    @fields
  end
  def get_buildings(centreX, centreY, zone = 5)
    @buildings = Hash.new
    self.buildings.where("posx BETWEEN ? and ? 
                        AND posy BETWEEN ? and ?",
                        centreX-zone, centreX+zone,
                        centreY-zone, centreY+zone).each do |building|
    
      @buildings["#{building.posx};#{building.posy}"] = building
     end
     @buildings
  end
  
  
  
end
