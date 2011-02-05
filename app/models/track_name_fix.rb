class TrackNameFix
  
  
  def batchScanTrackNameBracketsFix()
    bracketsCount = 0;
    isRedo = false;
    Tracks.find(:all).each do |track|
      strSource = track.name; 
      strRep = strSource.gsub(/\s*\([^)]*\)/, '');
      if (strSource.downcase != strRep.downcase)
        bracketsCount = bracketsCount + 1;
        TrackBracketFixStat.existOrNewFix(track, strRep.downcase, isRedo)        
      end              
    end
  end
  
  
  def batchTrackNameBracketsFixByMatchOtherTrackName()
    TrackBracketFixStat.find(:all, :conditions =>["status = ?" , 0 ]).each do |fix|
      status = fixTrackNameBracketsFixByMatchOtherTrackName(fix);
      TrackBracketFixStat.updateFixStatus(fix.track_id, status);
    end
  end
    
    
    
  def fixTrackNameBracketsFixByMatchOtherTrackName(fix)
    
    tracks = Tracks.find_by_artist_id(fix.artist_id);
    status = 0;
    if (tracks != nil)
      tracks.each do |track|
        if (track.name.downcase == fix.track_name_no_brackets.downcase)
          sts = track.similar_tracks
          status = 1;
          if (sts != nil)
            SimilarTrackNobracketsPatch.delete_all(:track_id => fix.track_id);
            sts.each do |st|
              st_patch = SimilarTrackNobracketsPatch.new;
              st_patch.track_id = st.track_id;
              st_patch.similar_track_id = st.similar_track_id;
              st_patch.version = st.version;
              st_patch.score = st.score;
              st_patch.appearance_times = st.appearance_times;
              st_patch.track_popularity = st.track_popularity;
              st_patch.save
              return 1;
            end # end of loop
          end # end of if                  
        end  # end of if        
    end    
    return status;                  
  end # end of function
   
end
