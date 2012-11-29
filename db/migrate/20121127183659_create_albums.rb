class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :artist
      t.string :genre
      t.integer :year
      t.integer :number_of_tracks
      t.integer :number_of_discs

      t.timestamps
    end
  end
end
