class AddSimilarTracksCountToVersionControl < ActiveRecord::Migration
  def self.up
      add_column :similar_tracks_version_controls, :similar_track_count, :integer
  end

  def self.down
  end
end
