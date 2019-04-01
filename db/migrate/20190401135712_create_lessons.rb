class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.integer :chapter_id
      t.timestamps
    end
  end
end
