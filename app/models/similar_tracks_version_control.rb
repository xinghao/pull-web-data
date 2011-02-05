# alter table similar_tracks change id pk_id int(11) NOT NULL AUTO_INCREMENT;
# insert into similar_tracks_version_controls (track_id, track_name, track_artist_id, status, version, has_similar_tracks) select id, name, artist_id, 0, 1, 0 from tracks;
# create table temp_st (track_id int(11));
#  insert into temp_st(track_id) select distinct(track_id) from similar_tracks where id <  5000000;
#  insert into temp_st(track_id) select distinct(track_id) from similar_tracks where id <  10000000 and id >= 5000000;
#  insert into temp_st(track_id) select distinct(track_id) from similar_tracks where id <  15000000 and id >= 10000000;
#  insert into temp_st(track_id) select distinct(track_id) from similar_tracks where id <  20000000 and id >= 15000000;
#  insert into temp_st(track_id) select distinct(track_id) from similar_tracks where id <  25000000 and id >= 20000000;
#  insert into temp_st(track_id) select distinct(track_id) from similar_tracks where id <  30000000 and id >= 25000000;
#  insert into temp_st(track_id) select distinct(track_id) from similar_tracks where id >= 30000000

# create table temp_st1 (track_id int(11));
# insert into temp_st1(track_id) select distinct(track_id) from temp_st;
#  drop table temp_st;

# update similar_tracks_version_controls set status = 2
# update similar_tracks_version_controls c, temp_st1 s set status = 1, has_similar_tracks = 1 where s.track_id = c.track_id

#  select max(track_id) from similar_tracks; 1650568
# update similar_tracks_version_controls set status = 0 where track_id > 1650568;
# alter table websource_track_similar_lastfm_v1s modify html mediumtext;

# status
# 0: not handled yet
# 5: scrape successful
## 1: has similar tracks by scrape last.fm
## 2: no similar tracks and we do not why because they are old data
## 3: name no match on lastfm
## 4: match on lastfm but no similar tracks
 
# 100: not do brackets fixed yet
# 101: match other songs with similar tracks
# 102: match other songs without similar tracks
# 103: no match on lastfm
# 104: match on lastfm but no similar tracks
# 105: match on lastfm with similar tracks


class SimilarTracksVersionControl < ActiveRecord::Base
  
  # currently not used.
  def self.newOrExistTrack(track, nameWithoutBrackets, isRedo, version)
    fix =SimilarTracksVersionControl.find_by_track_id(track_id);
    if (fix == nil)
      fix = SimilarTracksVersionControl.new;
      fix.track_id = track.id;
      fix.track_name = track.name;
      fix.track_artist_id = track.artist_id;
      fix.track_name_no_brackets = nameWithoutBrackets;
      fix.status = 0;
      fix.has_similar_tracks = 0;
      fix.version = version
      fix.save;
      return false;
    elsif (isRedo)
      fix.status = 0
      fix.has_similar_tracks = 0;
      fix.version = version            
      fix.save;    
      return false;  
    end
    
    return true;
    
  end

  def self.updateStatus(track_id, status, has_similar_track)
    fix =SimilarTracksVersionControl.find_by_track_id(track_id);
    fix.status = status;
    fix.has_similar_tracks = has_similar_track;
    fix.save;      
  end
  
  
  def getSimilarTracks()
    SimilarTracksVersionControl.find(:all, :conditions =>["status = ?" , 0 ]).each do |newTrack|
        #newTrack = SimilarTracksVersionControl.find(:first, :conditions =>["status = ?" , 0 ]);
        track = Track.find(newTrack.track_id);
        puts " processing(similar track raw data) :" + track.id.to_s

        lf = LastfmDataSourceHandler.new
        status = lf.getSimilarTrackWebRawDataImp(track)
        #status = 9
        puts "status : "+ status.to_s
        SimilarTracksVersionControl.updateStatus(track.id, status, 0);

   end #--end of album iteration 
  end

end
