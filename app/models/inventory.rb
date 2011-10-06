class Inventory < ActiveRecord::Base
   belongs_to :item
   belongs_to :player
end
