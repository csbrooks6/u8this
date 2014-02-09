class CreateServings < ActiveRecord::Migration
  def change
    create_table :servings do |t|
      t.belongs_to :user
      t.integer :day_order,          :null => false, :default => 0
      t.float :quantity,             :null => false, :default => 1.0
      t.string :name,                :null => false, :default => ""
      t.integer :calories,           :null => false, :default => 0
      t.date :when_eaten             :null => false

      t.timestamps
    end
  end
end
