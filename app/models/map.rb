class Map < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  has_many :players
end
