class UpdateSimilarTracksPopularity < ActiveRecord::Migration
  def self.up
    Track.find(:all, :conditions =>["is_valid = 1"] ).each do |track|
      puts "processing:" + track.id.to_s
      sql = "update similar_tracks set track_popularity = " + track.play_count.to_s + "/400677 where similar_track_id = " + track.id.to_s; 
      execute sql 
    end
    
      puts "add popularity done"
      puts "aggrageting appearance times.........."
      sql = "update similar_tracks set track_popularity = track_popularity + appearance_times"
      execute sql
    
  end

  def self.down
  end
end
