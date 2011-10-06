class AddLifePointPlayers < ActiveRecord::Migration
  def change
    add_column :players, :life_point, :integer, :default => 100
    add_column :players, :life_point_max, :integer, :default => 100
    
  end
end
