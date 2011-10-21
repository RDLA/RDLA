#encoding: utf-8
require "RPG"
class Player < ActiveRecord::Base
  attr_accessible :map, :user, :name, :posx, :posy, :map_id, :user_id, :description,
    :power, :power_max,:action, :action_max,:dexterity, :adroitness,
    :life_point, :life_point_max, :turn, :turn_action,  :constitution,
    :visual_acuity
  
  belongs_to :map
  belongs_to :user
  
  has_many :inventories
  accepts_nested_attributes_for :inventories
  
  validates :description, :length => { :maximum => 250 }
  validates :power, :presence => true, :numericality => true
  validates :power_max, :presence => true, :numericality => true
  validates :action, :presence => true, :numericality => true
  validates :action_max, :presence => true, :numericality => true
  
  #Auto_update task
  after_initialize do
    update_power() if self.turn + 1.minute < Time.now
    update_action() if self.turn_action + 1.minute < Time.now
    
  end
  include RPG
  
  def get_weapon()
    unless(self.inventories.right_hand.blank?)
      self.inventories.right_hand
    else
      unless(self.inventories.left_hand.blank?)
        self.inventories.left_hand
      else
        Item::Weapon.find_by_name("Poing")
      end
      
    end
  end
  
  def get_power_bar
    self.power * 100 / self.power_max
  end
  def get_action_bar
    self.action * 100 / self.action_max
  end
    def get_life_point_bar
    self.life_point * 100 / self.life_point_max
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
  
  def melee_fight_with(opponent)
    #Return [error, report]
    error = []
    report = []
    #Check if the player is not too far
    unless(self.get_distance_with(opponent.id) <= 1)
      error << "Vous êtes trop loin du joueur!"
    else
      #Calculate the opponent defense malus
      defense_malus = (opponent.power_max - opponent.power) / opponent.power_max * 10 + (opponent.life_point_max - opponent.life_point) / opponent.life_point_max * 10
      weapon = self.get_weapon()
      #Check if the player can use his weapon
      unless(self.power >= weapon.power_melee && self.action >= 1 )
        error << "Vous n'êtes pas assez en forme!" 
      else
        malus_dice = dice(1,100)
        report << "Rapport de combat avec #{opponent.name}"
        report << "Test de malus de défense opposant: #{malus_dice}/#{defense_malus}"
        
        if(malus_dice > defense_malus)
          report << "#{opponent.name} est prêt à se défendre!"
        #Normal defense
         
          attack_dice =  dice(self.dexterity)
          defense_dice =  dice([opponent.dexterity, opponent.adroitness].max)
          report << "Vous effectuez une passe d'arme avec #{opponent.name}: (#{attack_dice}/#{defense_dice})"
          if attack_dice > defense_dice
            report << "Vous touchez #{opponent.name}!"  
            attack_success = true
          else
            report << "Vous ratez #{opponent.name}!"  
            attack_success = false
          end
          
        else
        #Opponent must lose.
        report << "#{opponent.name} est surpris!"  
          attack_success = true
        end
        
        if attack_success
          
          damage = (0.1*self.power + weapon.power_melee - opponent.constitution).round
          report << "#{opponent.name} perd #{damage} points de vie!"  
          opponent.life_point = [ opponent.life_point-damage, 0 ].max
          report << "#{opponent.name} s'effondre sur le sol!" if opponent.life_point == 0  
        end
        
        self.power = self.power - weapon.power_melee
        self.action = self.action - 1
        self.save
        opponent.save
        
      end
    end
    [error, report]
  end
  
  
end
