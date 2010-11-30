class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist
  has_one :websource_track_similar_lastfm, :foreign_key=>"altnet_id"
  has_one :websource_track_similar_mtv, :foreign_key=>"altnet_id"
  has_one :aggregate_similar_tracks_stat, :foreign_key=>"altnet_id"
  has_one :websource_track_popular_echonest, :foreign_key=>"altnet_id"
  has_one :websource_track_popular_lastfm, :foreign_key=>"altnet_id"  
  
  def self.moodSearch(search)
    if search
      sql = "select tracks.id, tracks.name as track_name, artists.name as artist_name from tracks,artists where  tracks.name = '#{search}' and tracks.artist_id = artists.id and tracks.is_valid = 1";
      @tracks =  Track.find_by_sql(sql)

      #@tracks = find(:all, :conditions => ["name like ?", "%#{search}%"], :include => Artist);
    end
  end
  
  def self.moodRadio(popular_track)
    if id
      if (popular_track.tempo != nil && popular_track.energy != nil) then
        #sql = "select tracks.id, tracks.name as track_name, artists.name as artist_name, tracks.aggregated_popularity as popularity, tempo, energy, loudness, danceability from tracks,artists, popular_tracks where  tempo <= (#{popular_track.tempo} * 1.15) and tempo >= (#{popular_track.tempo} * 0.85) and energy <= (#{popular_track.energy} * 1.15) and energy >= (#{popular_track.energy} * 0.85) and altnet_id = tracks.id and tracks.artist_id = artists.id";
        sql = "select tracks.id, tracks.name as track_name, artists.name as artist_name, popularity, tempo, energy, loudness, danceability from tracks,artists, popular_tracks where  tempo <= (#{popular_track.tempo} * 1.004) and tempo >= (#{popular_track.tempo} * 0.996) and energy <= (#{popular_track.energy} * 1.004) and energy >= (#{popular_track.energy} * 0.996) and altnet_id = tracks.id and tracks.is_valid = 1 and tracks.artist_id = artists.id";
        @tracks =  Track.find_by_sql(sql)
        #puts @sql
      end
      #@tracks = find(:all, :conditions => ["name like ?", "%#{search}%"], :include => Artist);
    end
  end
  
end
