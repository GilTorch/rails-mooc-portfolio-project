class UserSolution < ActiveRecord::Migration[5.2]
  def change
    create_table :user_solutions do |t|
      t.text :content
      t.boolean :validated,:default => false 
      t.integer :user_lesson_id 
      t.timestamps
    end
  end
end
