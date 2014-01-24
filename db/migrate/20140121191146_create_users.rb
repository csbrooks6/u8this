class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :daily_calorie_goal

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
