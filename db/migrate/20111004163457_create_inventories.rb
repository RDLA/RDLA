class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :item_id
      t.integer :player_id
      t.integer :quantity

      t.timestamps
    end
  end
end
