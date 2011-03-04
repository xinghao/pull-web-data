class TrackNameFix
  
  
  def batchScanTrackNameBracketsFix()
    bracketsCount = 0;
    isRedo = false;
    SimilarTracksVersionControl.find(:all, :conditions => ["version = ? and status < ? and has_similar_tracks = ?" , 1, 100, 0]).each do |strack|
      strSource = strack.name; 
      strRep = strSource.gsub(/\s*\([^)]*\)/, '');
      strRep = strRep.gsub(/\s*\[[^)]*\]/, '');
      if (strSource.downcase != strRep.downcase)
        bracketsCount = bracketsCount + 1;
        #TrackBracketFixStat.existOrNewFix(strack, strRep.downcase, isRedo)
        #SimilarTracksVersionControl.updateStatusAndNoBracketsName(strack.track_id, 100, strRep.downcase);
        strack.status = status;
        strack.track_name_no_brackets = nameWithoutBrackets;
        strack.save;      
   
      end              
    end
  end
  
  
  def batchTrackNameBracketsFixByMatchOtherTrackName()
    SimilarTracksVersionControl.find(:all, :conditions =>["status = ?" , 100 ]).each do |fix|
      status = fixTrackNameBracketsFixByMatchOtherTrackName(fix);
      fix.status = status;     
      fix.save;      

    end
  end
    
    
    
  def fixTrackNameBracketsFixByMatchOtherTrackName(fix)
    
    tracks = Tracks.find_by_artist_id(fix.track_artist_id);
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
