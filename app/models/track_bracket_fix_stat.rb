# Status:
# 0: not fixed yet
# 1: match other songs with similar tracks
# 2: match other songs without similar tracks
# 3: no match on lastfm
# 4: match on lastfm but no similar tracks
# 5: match on lastfm with similar tracks


class TrackBracketFixStat < ActiveRecord::Base

  def self.newOrExistFix(track, nameWithoutBrackets, isRedo)
    fix =TrackBracketFixStat.find_by_track_id(track_id);
    if (fix == nil)
      fix = TrackBracketFixStat.new;
      fix.track_id = track.id;
      fix.track_name = track.name;
      fix.artist_id = track.artist_id;
      fix.track_name_no_brackets = nameWithoutBrackets;
      fix.status = 0
      fix.save;
    elsif (isRedo)
      fix.status = 0
      fix.save;      
    end
    
  end

  def self.updateFixStatus(track_id, status)
    fix =TrackBracketFixStat.find_by_track_id(track_id);
    fix.status = status;
    fix.save;      
  end
  
end
