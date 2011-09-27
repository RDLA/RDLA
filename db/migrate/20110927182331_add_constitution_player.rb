class AddConstitutionPlayer < ActiveRecord::Migration
  def change
    add_column :players, :constitution, :integer, :default => 5
  end
end
