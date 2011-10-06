class Inventory < ActiveRecord::Base
   belongs_to :item
   belongs_to :player
   
  validates :location, :inclusion => {:in => %w(bag left_hand right_hand) }
  
  scope :bag, where("location='bag'")
  scope :left_hand, where("location='left_hand'")
  scope :right_hand, where("location='right_hand'")
  
  
end
