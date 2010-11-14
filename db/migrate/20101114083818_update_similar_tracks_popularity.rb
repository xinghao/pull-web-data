class UpdateSimilarTracksPopularity < ActiveRecord::Migration
  def self.up
    # Track.find(:all, :conditions =>["is_valid = 1"] ).each do |track|
    #   puts "processing:" + track.id.to_s
    #   sql = "update similar_tracks set track_popularity = " + track.play_count.to_s + "/400677 where similar_track_id = " + track.id.to_s; 
    #   execute sql 
    # end    
  end

  def self.down
  end
end
