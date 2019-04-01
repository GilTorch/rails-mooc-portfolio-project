class CreateUserChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :user_chapters do |t|
      t.integer :user_id
      t.integer :chapter_id
      t.boolean :passed

      t.timestamps
    end
  end
end
