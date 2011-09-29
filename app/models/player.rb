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
  
  
end
