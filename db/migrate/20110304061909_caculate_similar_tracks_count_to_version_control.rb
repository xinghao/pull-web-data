class CaculateSimilarTracksCountToVersionControl < ActiveRecord::Migration
  def self.up
    execute 'craete table temp_sc1 (track_id int(11), similar_tracks_count int(11));'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  100000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  200000 and track_id >= 100000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  300000 and track_id >= 200000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  400000 and track_id >= 300000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  500000 and track_id >= 400000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  600000 and track_id >= 500000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  700000 and track_id >= 600000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  800000 and track_id >= 700000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  900000 and track_id >= 800000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1000000 and track_id >= 900000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1100000 and track_id >= 1000000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1200000 and track_id >= 1100000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1300000 and track_id >= 1200000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1400000 and track_id >= 1300000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1500000 and track_id >= 1400000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1600000 and track_id >= 1500000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  1700000 and track_id >= 1600000;'
    execute 'insert into temp_sc1(track_id, similar_tracks_count) select track_id, count(distinct similar_track_id) from similar_tracks where track_id <  180000 and track_id >= 1700000;'
    
    
    execute 'update similar_tracks_version_controls c, temp_sc1 s set c.similar_tracks_count = s.similar_tracks_count where s.track_id = c.track_id;'
    
  end

  def self.down
  end
end
