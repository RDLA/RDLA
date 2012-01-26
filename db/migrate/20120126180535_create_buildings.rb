class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.integer :map_id
      t.integer :posx
      t.integer :posy
      t.string :icon_url

      t.timestamps
    end
  end
end
