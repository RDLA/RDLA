class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      
      #Position on map
      t.integer :map_id
      t.integer :posx
      t.integer :posy
      
      #User
      t.integer :user_id

      t.timestamps
    end
    add_index(:players, [:map_id, :posx, :posy], :unique => true)
  end
end
