class CreatePopularTracks < ActiveRecord::Migration
  def self.up
    create_table :popular_tracks do |t|
      t.integer :altnet_id
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
    add_index :popular_tracks, [:altnet_id]
  end

  def self.down
    drop_table :popular_tracks
  end
end
