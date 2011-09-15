class CreateTerraformings < ActiveRecord::Migration
  def change
    create_table :terraformings do |t|
      t.integer :map_id
      t.integer :posx
      t.integer :posy
      t.integer :field_id

      t.timestamps
      
    end
    add_index :terraformings, [:map_id, :posx, :posy], :unique => true
  end
end
