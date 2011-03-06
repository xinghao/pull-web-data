class TrackNameFix
  # run this first
  def batchScanTrackNameBracketsFix()
    bracketsCount = 0;
    isRedo = false;
    SimilarTracksVersionControl.find(:all, :conditions => ["version = ? and status < ?" , 1, 100]).each do |strack|
      puts "track_id:" + strack.track_id.to_s();
      strSource = strack.track_name; 
      strRep = strSource.gsub(/\s*\([^)]*\)/, '');
      strRep = strRep.gsub(/\s*\[[^)]*\]/, '');
      
      strack.track_name_no_brackets = strRep;
      
      if (strSource.downcase != strRep.downcase && strack.has_similar_tracks = 0)
        bracketsCount = bracketsCount + 1;
        strack.status = 100;
      end #end of if
      
      strack.save;
                
    end #end of loop
    puts "total needs fix:" + bracketsCount.to_s();
    
  end
  
  #run this second
  def batchTrackNameBracketsFixByMatchOtherTrackName()
    SimilarTracksVersionControl.find(:all, :conditions =>["status = ?" , 100 ]).each do |fix|
      puts "handling:" + fix.track_id.to_s;
      status = fixTrackNameBracketsFixByMatchOtherTrackName(fix);
    end
  end
    


  def fixTrackNameBracketsFixByMatchOtherTrackName(fix)
    
    scs = SimilarTracksVersionControl.find(:all, :order => "similar_track_count desc", :limit => 1, :conditions => ["(track_name = ? or track_name_no_brackets = ?) and track_artist_id = ? and track_id != ? and status < ?", fix.track_name_no_brackets, fix.track_name_no_brackets, fix.track_artist_id, fix.track_id, 100])
    status = 0;
    if (scs != nil and !scs.empty?)
      sc = scs.first;
      
      puts "matched track_id:" + sc.track_id.to_s();
      #do need scrape for this case.
      if (sc.has_similar_tracks == 0)
        fix.no_bracket_track_id = sc.track_id;
        fix.status = 152;
        fix.save();
        return 152;        
      end
        
      sts = SimilarTrack.find(:all, :conditions => ["track_id = ?", sc.track_id]);
      if (sts != nil and !sts.empty?)
        SimilarTrackNobracketsPatch.delete_all(:track_id => fix.track_id);
        sts.each do |st|
          st_patch = SimilarTrackNobracketsPatch.new;
          st_patch.track_id = fix.track_id;
          st_patch.similar_track_id = st.similar_track_id;
          st_patch.version = st.version;
          st_patch.score = st.score;
          st_patch.appearance_times = st.appearance_times;
          st_patch.track_popularity = st.track_popularity;
          st_patch.save
        end # end of loop

        fix.status = 151;
        fix.similar_track_count = sc.similar_track_count;
        fix.has_similar_tracks  = sc.has_similar_tracks;
        fix.no_bracket_track_id = sc.track_id;
        fix.save();
        return 151;        

      end #end of it sts empty
    end # end of if scs empty          
      
    fix.status = 153;
    fix.save();
    return 153;        

    return status;                  
  end # end of function
      
   #run this third
  def batchTrackNameBracketsFixByScrapingGeting()
      st = SimilarTracksVersionControl.new();
      st.getSimilarTracks(100, 153);
  end   
  
   #run this forth
  def batchTrackNameBracketsFixByScrapingAnalyzing()
      st = SimilarTracksVersionControl.new();
      st.analyzeSimilarTracks(100, 105);
  end   
 
 
  #run this five
  def batchTrackNameBracketsFixByScrapingAggregating()
      st = SimilarTracksVersionControl.new();
      st.analyzeSimilarTracks(100, 105);
  end  
  # def fixTrackNameBracketsFixByMatchOtherTrackName(fix)
  #   
  #   tracks = Tracks.find_by_artist_id(fix.track_artist_id);
  #   status = 0;
  #   if (tracks != nil)
  #     tracks.each do |track|
  #       if (track.name.downcase == fix.track_name_no_brackets.downcase)
  #         sts = track.similar_tracks
  #         status = 1;
  #         if (sts != nil)
  #           SimilarTrackNobracketsPatch.delete_all(:track_id => fix.track_id);
  #           sts.each do |st|
  #             st_patch = SimilarTrackNobracketsPatch.new;
  #             st_patch.track_id = st.track_id;
  #             st_patch.similar_track_id = st.similar_track_id;
  #             st_patch.version = st.version;
  #             st_patch.score = st.score;
  #             st_patch.appearance_times = st.appearance_times;
  #             st_patch.track_popularity = st.track_popularity;
  #             st_patch.save
  #             return 1;
  #           end # end of loop
  #         end # end of if                  
  #       end  # end of if        
  #   end    
  #   return status;                  
  # end # end of function
   
end
