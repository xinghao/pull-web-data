class AdNoBracketMatchTrackIdToVersionControlTable < ActiveRecord::Migration
  def self.up
    add_column :similar_tracks_version_controls, :no_bracket_track_id, :integer
  end

  def self.down
  end
end
