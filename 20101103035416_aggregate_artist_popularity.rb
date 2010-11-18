class AggregateArtistPopularity < ActiveRecord::Migration
  def self.up
     max_play_acount_kazaa =  Artist.maximum(:tracks_play_count)
     max_play_acount_lastfm = PopularArtist.maximum(:lastfm)#3150173.0
#     sql = "select artists.*, lastfm, echonest from artists left join popular_artists on artists.id = popular_artists.artist_id"
#    Artist.find_by_sql(sql).each do |artist|
    Artist.find(:all).each do |artist|
      kazaa_pop =((artist.tracks_play_count == nil)? 0 : artist.tracks_play_count) / max_play_acount_kazaa.to_f
      
      popular_artist = PopularArtist.find_by_artist_id(artist.id)
      if (popular_artist == nil)
        lastfm_pop = 0
        echonest_pop = 0
      else
        lastfm_pop    = ((popular_artist.lastfm == nil)? 0 : popular_artist.lastfm) / max_play_acount_lastfm.to_f
        echonest_pop = ((popular_artist.echonest == nil)? 0 : popular_artist.echonest)
      end
      #puts "kazaa_pop:" + kazaa_pop.to_s
      #puts "lastfm_pop:" + lastfm_pop.to_s
      #puts "echonest_pop:" + echonest_pop.to_s 
      aggregate_pop = 0
      if (lastfm_pop != 0 && echonest_pop != 0 && kazaa_pop != 0)
        aggregate_pop = lastfm_pop*0.5 + echonest_pop*0.3 +  kazaa_pop*0.2
      elsif (lastfm_pop != 0 && echonest_pop != 0 && kazaa_pop == 0)
        aggregate_pop = lastfm_pop*0.6 + echonest_pop*0.4
      elsif ((lastfm_pop != 0 && echonest_pop == 0 && kazaa_pop != 0) ||
        (lastfm_pop == 0 && echonest_pop != 0 && kazaa_pop != 0))
        aggregate_pop = (lastfm_pop+echonest_pop)*0.7 + echonest_pop*0.2
      elsif ((lastfm_pop != 0 && echonest_pop == 0 && kazaa_pop == 0) ||
        (lastfm_pop == 0 && echonest_pop != 0 && kazaa_pop == 0))
        aggregate_pop = (lastfm_pop+echonest_pop)*0.8
      elsif (lastfm_pop == 0 && echonest_pop == 0 && kazaa_pop != 0)
        aggregate_pop = kazaa_pop
      end # end of if
      #puts "aggregate_pop"+ artist.id.to_s+":"+aggregate_pop.to_s
      artist.aggregated_popularity = aggregate_pop
      artist.save
                              
    end
    # execute "update artists, popular_artists set artists.aggregated_popularity = popular_artists.popularity +  artists.tracks_play_count/" + max_play_acount.to_s + " where artists.id = popular_artists.artist_id"
  end

  def self.down
    #execute "update artists set artists.aggregated_popularity = 0"
  end
end
