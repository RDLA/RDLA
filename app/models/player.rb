class Player < ActiveRecord::Base
  attr_accessible :map, :user, :name, :posx, :posy, :map_id, :user_id, :description,
    :power, :power_max, :turn, :constitution
  
  belongs_to :map
  belongs_to :user
  
  validates :description, :length => { :maximum => 250 }
  validates :power, :presence => true, :numericality => true
  validates :power_max, :presence => true, :numericality => true
  
  after_initialize do
    
    update_power() if self.turn + 1.minute < Time.now
  end
  
  def get_power_bar
     self.power * 200 / self.power_max
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
#    p "Algo: #{base_count} g/s, second_past: #{second_past}s, win: #{win}, #{self.turn}"
  end
  
  
end
