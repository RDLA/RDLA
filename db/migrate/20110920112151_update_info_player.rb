class UpdateInfoPlayer < ActiveRecord::Migration
  def change
    add_column :players, :description, :string
  end
end
