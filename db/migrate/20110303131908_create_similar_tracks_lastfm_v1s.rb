class CreateSimilarTracksLastfmV1s < ActiveRecord::Migration
  def self.up
    create_table :similar_tracks_lastfm_v1s do |t|
      t.integer :altnet_id
      t.integer :similar_artist_id
      t.integer :similar_album_id
      t.integer :similar_track_id
      t.integer :score

      t.timestamps
    end
    
    add_index :similar_tracks_lastfm_v1s, [:altnet_id]
  end

  def self.down
    remove_index :similar_tracks_lastfm_v1s, [:altnet_id]
    drop_table :similar_tracks_lastfm_v1s
  end
end
