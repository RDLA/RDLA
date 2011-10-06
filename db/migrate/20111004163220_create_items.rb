class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.integer :lot
      t.string :type
      
      #Weapons
      t.integer :power_melee
      t.integer :power_melee_step
      t.integer :dexterity
      t.integer :hands_number
      t.decimal :critical_rate
      
      t.timestamps
    end
  end
end
