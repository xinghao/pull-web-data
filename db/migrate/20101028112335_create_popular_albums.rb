class CreatePopularAlbums < ActiveRecord::Migration
  def self.up
    create_table :popular_albums do |t|
      t.integer :album_id
      t.decimal :playstats, :precision => 65, :scale => 30
      t.decimal :mz, :precision => 65, :scale => 30
      t.decimal :lastfm, :precision => 65, :scale => 30
      t.decimal :lastfm_handled, :precision => 65, :scale => 30
      t.decimal :echonest, :precision => 65, :scale => 30
      t.decimal :yahoomusic, :precision => 65, :scale => 30
      t.decimal :mtv, :precision => 65, :scale => 30
      t.decimal :popularity, :precision => 65, :scale => 30
      t.integer :version, :default => 0 
      t.timestamps
    end
    add_index :popular_albums, [:album_id]
  end

  def self.down
    remove_index :popular_albums, [:album_id]
    drop_table :popular_albums
  end
end
