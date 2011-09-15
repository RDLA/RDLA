class UpdateMap < ActiveRecord::Migration
  def change
    add_column :maps, :default_field_id, :integer
  end

 
end
