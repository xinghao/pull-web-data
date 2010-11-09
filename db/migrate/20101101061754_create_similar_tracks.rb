class CreateSimilarTracks < ActiveRecord::Migration
  def self.up
    create_table :similar_tracks do |t|
      t.integer :altnet_id
      t.integer :similar_artist_id
      t.integer :similar_album_id
      t.integer :similar_track_id
      t.decimal :score, :precision => 65, :scale => 30

      t.timestamps
    end
    add_index :similar_tracks, [:altnet_id]
  end

  def self.down
    remove_index :similar_tracks, [:altnet_id]
    drop_table :similar_tracks
  end
end