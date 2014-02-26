class AddLastUnitCaloriesToFood < ActiveRecord::Migration
  def change
    add_column :foods, :last_unit_calories, :float, :null => false, :default => 0.0
  end
end
