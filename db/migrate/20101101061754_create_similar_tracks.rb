class CreateSimilarTracks < ActiveRecord::Migration
  def self.up
    create_table :similar_tracks do |t|
      t.integer :altnet_id
      t.integer :similar_artist_id
      t.integer :similar_album_id
      t.integer :similar_track_id
      t.integer :version, :default=>0
      t.decimal :score, :precision => 65, :scale => 30
      t.integer :appearance_times, :default => 0
      t.decimal :track_popularity, :precision => 10, :scale => 8, :default=>0

      t.timestamps
    end
    add_index :similar_tracks, [:altnet_id]
  end

  def self.down
    remove_index :similar_tracks, [:altnet_id]
    drop_table :similar_tracks
  end
end
