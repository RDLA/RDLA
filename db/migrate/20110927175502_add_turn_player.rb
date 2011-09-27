class AddTurnPlayer < ActiveRecord::Migration
 def change
    add_column :players, :turn, :datetime, :default => Time.now
  end
end
