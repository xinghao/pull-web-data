class CreateLastfmTrackPopularTemps < ActiveRecord::Migration
  def self.up
    create_table :lastfm_track_popular_temps do |t|
      t.integer :track_id
      t.integer :similar_track_id
    end
  end

  def self.down
    drop_table :lastfm_track_popular_temps
  end
end
