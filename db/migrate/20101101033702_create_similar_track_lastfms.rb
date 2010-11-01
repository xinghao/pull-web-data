class CreateSimilarTrackLastfms < ActiveRecord::Migration
  def self.up
    create_table :similar_track_lastfms do |t|
      t.integer :altnet_id
      t.integer :similar_artist_id
      t.integer :similar_album_id
      t.integer :similar_track_id
      t.integer :score

      t.timestamps
    end
    add_index :similar_track_lastfms, [:altnet_id]
  end

  def self.down
    remove_index :similar_track_lastfms, [:altnet_id]
    drop_table :similar_track_lastfms
  end
end
