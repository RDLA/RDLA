class AddVisualAcuityPlayers < ActiveRecord::Migration
  def change
    add_column :players, :visual_acuity, :integer, :default => 5
  end
end
