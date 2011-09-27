class AddPowerPlayers < ActiveRecord::Migration
  def change
    add_column :players, :power, :integer, :default => 60
    add_column :players, :power_max, :integer, :default => 60
  end
end
