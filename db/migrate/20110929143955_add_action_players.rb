class AddActionPlayers < ActiveRecord::Migration
  def change
    add_column :players, :action, :integer, :default => 5
    add_column :players, :action_max, :integer, :default => 5
    add_column :players, :turn_action, :datetime, :default => Time.now
    
  end
end
