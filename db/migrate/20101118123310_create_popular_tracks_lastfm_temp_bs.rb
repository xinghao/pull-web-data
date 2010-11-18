class CreatePopularTracksLastfmTempBs < ActiveRecord::Migration
  def self.up
    create_table :popular_tracks_lastfm_temp_bs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :popular_tracks_lastfm_temp_bs
  end
end
