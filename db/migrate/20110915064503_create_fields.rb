class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :filename

      t.timestamps
    end
  end
end
