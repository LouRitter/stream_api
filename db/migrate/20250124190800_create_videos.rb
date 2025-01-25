class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.string :genre
      t.date :release_date
      t.decimal :rating, precision: 5, scale: 2

      t.timestamps
    end
  end
end
