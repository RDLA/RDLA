class AddAdroitnessPlayers < ActiveRecord::Migration
  def change
    add_column :players, :adroitness, :integer, :default => 10
  end
end
