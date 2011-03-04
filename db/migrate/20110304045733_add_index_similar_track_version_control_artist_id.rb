class AddIndexSimilarTrackVersionControlArtistId < ActiveRecord::Migration
  def self.up
    add_index :similar_tracks_version_controls, [:track_artist_id]
  end

  def self.down
    remove_index :similar_tracks_version_controls, [:track_artist_id]
  end
end
