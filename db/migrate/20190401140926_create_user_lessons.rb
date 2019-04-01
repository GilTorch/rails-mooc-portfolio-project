class CreateUserLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :user_lessons do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.boolean :passed,:default => false

      t.timestamps
    end
  end
end
