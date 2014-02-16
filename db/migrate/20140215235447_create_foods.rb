class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.belongs_to :user,         :null => false
      t.string :name,             :null => false
      t.integer :ref_count,       :null => false, :default => 0

      t.timestamps
    end

    add_index :foods, [:user_id], order: [:user_id]
  end
end
