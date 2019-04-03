class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.boolean :is_a_lab,default: false
      t.text :content
      t.integer :chapter_id
      t.timestamps
    end
  end
end
