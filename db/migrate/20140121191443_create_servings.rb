class CreateServings < ActiveRecord::Migration
  def change
    create_table :servings do |t|
      t.belongs_to :user
      t.integer :day_order
      t.float :quantity
      t.string :name
      t.integer :calories
      t.date :when_eaten

      t.timestamps
    end
  end
end
