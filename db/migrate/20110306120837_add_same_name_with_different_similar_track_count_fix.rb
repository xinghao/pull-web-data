class AddSameNameWithDifferentSimilarTrackCountFix < ActiveRecord::Migration
  def self.up
    add_column :similar_tracks_version_controls, :same_name_with_different_similar_track_count_fix, :integer
  end

  def self.down
  end
end
