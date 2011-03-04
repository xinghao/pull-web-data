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

# craete table temp_sc1 (track_id int(11), similar_tracks_count int(11));
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  100000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  200000 and track_id >= 100000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  300000 and track_id >= 200000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  400000 and track_id >= 300000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  500000 and track_id >= 400000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  600000 and track_id >= 500000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  700000 and track_id >= 600000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  800000 and track_id >= 700000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  900000 and track_id >= 800000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1000000 and track_id >= 900000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1100000 and track_id >= 1000000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1200000 and track_id >= 1100000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1300000 and track_id >= 1200000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1400000 and track_id >= 1300000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1500000 and track_id >= 1400000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1600000 and track_id >= 1500000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1700000 and track_id >= 1600000;
#  insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  180000 and track_id >= 1700000;


# update similar_tracks_version_controls c, temp_sc1 s set c.similar_tracks_count = s.similar_tracks_count where s.track_id = c.track_id;
# update similar_tracks_version_controls set similar_track_count = 0 where similar_track_count is null;
#select count(*) from similar_tracks_version_controls where has_similar_tracks = 0 and similar_tracks_count > 0
#select count(*) from similar_tracks_version_controls where has_similar_tracks = 1 and similar_track_count = 0



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

#12 : find similar tracks
 
# 100: not do brackets fixed yet
# 151: match other songs with similar tracks
# 152: match other songs without similar tracks
# 153: no match ready to scrape
# 154: match on lastfm but no similar tracks
# 155: match on lastfm with similar tracks


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
      fix.status = 100;
      fix.has_similar_tracks = 0;
      fix.version = version
      fix.save;
      return false;
    elsif (isRedo)
      fix.track_name_no_brackets = nameWithoutBrackets;
      fix.status = 100
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
  
  #normal base => 0, status = 0
  #nobracketfix base => 100, status = 153
  def getSimilarTracks(base, status)
    SimilarTracksVersionControl.find(:all, :conditions =>["status = ?" , status ]).each do |newTrack|
        #newTrack = SimilarTracksVersionControl.find(:first, :conditions =>["status = ?" , 0 ]);
        track = Track.find(newTrack.track_id);
        puts " processing(similar track raw data) :" + track.id.to_s

        lf = LastfmDataSourceHandler.new
        pstatus = lf.getSimilarTrackWebRawDataImp(track) + base;
        #status = 9
        puts "status : "+ status.to_s
        SimilarTracksVersionControl.updateStatus(track.id, pstatus, 0);

   end #--end of album iteration 
  end

  #normal base => 0, status = 5
  #nobracketfix base => 100, status = 105
  def analyzeSimilarTracks(base, pstatus)    
    #SimilarTracksVersionControl.find(:all, :order=>"track_id", :conditions =>["status = ?" , 5], :limit => 1).each do |ps|
    SimilarTracksVersionControl.find(:all, :order=>"track_id", :conditions =>["status = ?" , pstatus]).each do |ps|
      puts ps.track_id.to_s;
        track = Track.find(ps.track_id);
        
        puts  " analyzing(raw data) :" + ps.id.to_s + "-" + track.id.to_s
    
        begin
          lm = LastfmDataSourceHandler.new;
          status = lm.analyzeSimilarTrackRawDataImp(track) + base;
        rescue Exception => e
          puts e
          status = 7 + base;
        end 
        
        begin
          puts "status : "+ status.to_s
          SimilarTracksVersionControl.updateStatus(track.id, status, 0);
          
        rescue Exception => e
          puts e
        end 
        
    end
  end
  
  #normal base => 0, status = 5
  #nobracketfix base => 100, status = 112  
  def aggregateSimilarTracks(base, pstatus) 
   SimilarTracksVersionControl.find(:all, :order=>"track_id", :conditions =>["status = ?" , pstatus]).each do |ps|   
     # if (!alreadyHandled(track, "similar tracks"))
         h = Hash.new
         
        puts "Aggregator :" + ps.track_id.to_s
        # LASTFM
        relateLastfms = SimilarTracksLastfmV1.find(:all, :select => 'DISTINCT  similar_track_id, score', :conditions =>["altnet_id = ?", ps.track_id])
        a = Aggregator.new;
        a.startSingleDataSourceTrack(relateLastfms, h, "lastfm")     
        #MTV
        # relateMtvs = SimilarTrackMtv.find(:all, :select => 'DISTINCT  similar_track_id, score', :conditions =>["altnet_id = ?", ps.track_id])
        # startSingleDataSourceTrack(relateMtvs, h, "mtv")
        
        icount = 0
        h.each_pair do |sid, sas|
           sa = SimilarTrack.new
           sa.track_id = ps.track_id
#           sa.similar_artist_id = sid
           sa.similar_track_id = sid
           sa.score = sas.getScore
           sa.appearance_times = sas.getScore.to_i
           sa.save
          #puts sid.to_s + ":"+ sas.getScore.to_s
          icount = icount+1  
        end
        
        puts "total:" + icount.to_s
        if (icount == 0)
          status = 4 + base;
          SimilarTracksVersionControl.updateStatus(ps.track_id, status, 0);
        else
          status = 1 + base;
          SimilarTracksVersionControl.updateStatus(ps.track_id, status, 1);
        end
        
        puts status.to_s
     #   updateAstatus(track, status, "similar tracks")

     # end   #end of if  
    end
  end  
end
