class Player < ActiveRecord::Base
  attr_accessible :map, :user, :name, :posx, :posy, :map_id, :user_id, :description,
    :power, :power_max,:action, :action_max, :turn, :constitution
  
  belongs_to :map
  belongs_to :user
  
  validates :description, :length => { :maximum => 250 }
  validates :power, :presence => true, :numericality => true
  validates :power_max, :presence => true, :numericality => true
  validates :action, :presence => true, :numericality => true
  validates :action_max, :presence => true, :numericality => true
  
  after_initialize do
    
    update_power() if self.turn + 1.minute < Time.now
    update_action() if self.turn_action + 1.minute < Time.now
  end
  
  def get_power_bar
    self.power * 100 / self.power_max
  end
  def get_action_bar
    self.action * 100 / self.action_max
  end
  
  def update_power
    #Update the power according to the previous time
    # ENT(P/Pmax*4+Con*0,5) / 86400
    base_count = ((self.power/self.power_max)*4 + (self.constitution.to_f)*0.5) / 86400.to_f
    second_past = Time.now.to_time.to_i - self.turn.to_time.to_i
    win = (base_count*second_past).floor
    if win >= 1
      self.power = [self.power + win, self.power_max].min
      self.turn = self.turn + (win / base_count).floor
      self.save
    end

  end
  def update_action
    #Update the action according to the previous time
 
    base_count = self.action_max / 86400.to_f
    second_past = Time.now.to_time.to_i - self.turn_action.to_time.to_i
    win = (base_count*second_past).floor
    if win >= 1
      self.action = [self.action + win, self.action_max].min
      self.turn_action = self.turn_action + (win / base_count).floor
      self.save
    end

  end
  def get_distance_with(player_id)
    player = Player.find player_id rescue self
    [(player.posx-self.posx).abs, (player.posy-self.posy).abs ].max
  end
  
  def can_go(path)
    #Check if the user can go to a specified target with the current path
    road = path.split("/")
    current_x = self.posx
    current_y = self.posy
    can_go = true
    road.each do |pos|
      unless pos.blank?
        p = pos.split(";")
        next_x = p[0].to_i
        next_y = p[1].to_i
        
        pos_valid = true
        
        #Is the position close to the player?
        if( (current_x - next_x).abs > 1 && (current_y - next_y).abs > 1)
          pos_valid = false
        end
        
        #Is there a player on the position?
        player = Player.find_by_posx_and_posy_and_map_id(next_x, next_y, self.map_id)
        pos_valid = false unless player.blank?
         
        if pos_valid
          current_x = next_x
          current_y = next_y
        else
          can_go = false
        end
        
      end
    end
    can_go
  end
  
  
end
