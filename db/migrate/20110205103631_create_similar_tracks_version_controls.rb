class CreateSimilarTracksVersionControls < ActiveRecord::Migration
  def self.up
    create_table :similar_tracks_version_controls do |t|
      t.integer :track_id
      t.string :track_name
      t.string :track_name_no_brackets
      t.integer :track_artist_id
      t.integer :status
      t.integer :version
      t.integer :has_similar_tracks

      t.timestamps
    end
    
     add_index :similar_tracks_version_controls, [:track_id]
  end

  def self.down
    remove_index :similar_tracks_version_controls, [:track_id]
    drop_table :similar_tracks_version_controls
  end
end
