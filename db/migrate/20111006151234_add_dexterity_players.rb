class AddDexterityPlayers < ActiveRecord::Migration
  def change
     add_column :players, :dexterity, :integer, :default => 10
  end
end
