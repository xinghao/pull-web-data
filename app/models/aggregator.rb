class Aggregator
    def initialize
    end

  def aggregateSimilarTracks iOffset, iLimit
    #pTracks = SimilarPTrackStat.find(:all, :offset => iOffset, :limit => iLimit, :conditions =>["mtv = 5 and lastfm = 5"])
   #pTracks = SimilarPTrackStat.find(:all, :conditions =>["mtv = 5 and lastfm = 5"])
   Tracks.find(:all, :offset => iOffset, :limit => iLimit).each do |track|
      if (!alreadyHandled(track, "similar tracks"))
         h = Hash.new
         
        puts "Aggregator :" + track.id.to_s
        # LASTFM
        relateLastfms = SimilarTrackLastfm.find(:all, :select => 'DISTINCT similar_artist_id, similar_album_id, similar_track_id, score', :conditions =>["altnet_id = ?", track.id])
        startSingleDataSourceTrack(relateLastfms, h, "lastfm")     
        #MTV
        relateMtvs = SimilarTrackMtv.find(:all, :select => 'DISTINCT similar_artist_id, similar_album_id, similar_track_id, score', :conditions =>["altnet_id = ?", track.id])
        startSingleDataSourceTrack(relateMtvs, h, "mtv")
        
        icount = 0
        h.each_pair do |sid, sas|
           sa = SimilarTrack.new
           sa.altnet_id = track.id
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
          status = 2
        else
          status = 1
        end
        
        puts status.to_s
        updateAstatus(track, status, "similar tracks")

      end   #end of if  
    end
  end
  
  def start
    #2402 the rolling stones
    #1785 beyonce
    #2190 the black eyed peas
    #2   Doves
   #art = Artist.find(2402)
   icount = 0
   iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   iLimit = 10
   #Artist.find(:all, :offset => iOffset, :limit => iLimit).each do |art|
   Artist.find(:all).each do |art|
      h = Hash.new
      puts "Aggregator :" + art.id.to_s
      if (!alreadyHandled(art)) 
        
        # LASTFM
        relateLastfms = RelateLastfm.find(:all, :select => 'DISTINCT similar_artist_id, position', :conditions =>["altnet_id = ?", art.id])     
        startSingleDataSource(relateLastfms, h, "lastfm")

        #MUSICBRAINZS
        relateMzs = RelateMusicbrainz.find(:all, :select => 'DISTINCT similar_artist_id, position', :conditions =>["altnet_id = ?", art.id])
        startSingleDataSource(relateMzs, h, "mz")

        #ECHONEST
        relateEchonests = RelateEchonest.find(:all, :select => 'DISTINCT similar_artist_id, position', :conditions =>["altnet_id = ?", art.id])
        startSingleDataSource(relateEchonests, h, "echonest")
        
        #YAHOOMUSIC
        relateyahoomusics = RelateYahoomusic.find(:all, :select => 'DISTINCT similar_artist_id, position', :conditions =>["altnet_id = ?", art.id])
        startSingleDataSource(relateyahoomusics, h, "yahoomusic")
        
        #MTV
        relateMtvs = RelateMtv.find(:all, :select => 'DISTINCT similar_artist_id, position', :conditions =>["altnet_id = ?", art.id])
        startSingleDataSource(relateMtvs, h, "mtv")
        
        icount = 0
        h.each_pair do |sid, sas|
           sa = SimilarArtist.new
           sa.artist_id = art.id
           sa.similar_artist_id = sid
           sa.similar_score = sas.getScore
           sa.save
          #puts sid.to_s + ":"+ sas.getScore.to_s
          icount = icount+1  
        end
        
        puts "total:" + icount.to_s
        if (icount == 0)
          status = 2
        else
          status = 1
        end
        
        puts status.to_s
        updateAstatus(art, status)
        
      end      
   end # end of artist iteration
  end
  
  
  def startSingleDataSource(relations, h, datasource_type)
    relations.each do |ref|
      sas = h[ref.similar_artist_id]
      if (sas == nil)        
        sas = SimilarArtistScore.new
        h[ref.similar_artist_id] = sas
      end
      
      sas.calculate(ref.position.to_f, datasource_type)
    end
  end
  
  def startSingleDataSourceTrack(relations, h, datasource_type)
    relations.each do |ref|
      sas = h[ref.similar_track_id]
      if (sas == nil)        
        sas = SimilarTrackScore.new
        h[ref.similar_track_id] = sas
      end
      
      sas.calculate(ref.score.to_f, datasource_type)
    end
  end

  
  # check if this artist has already been handled
  def alreadyHandled art, process_type
    if (process_type == "similar artists")
      aStat = art.a_stat
    elsif (process_type == "similar tracks")
      aStat = art.aggregate_similar_tracks_stat
    end
    if (aStat == nil) 
    if (process_type == "similar artists")
      aStat =  AStat.new
    elsif (process_type == "similar tracks")
      aStat = AggregateSimilarTracksStat.new
    end
      
      
      aStat.altnet_id = art.id
      aStat.status = 0
      aStat.save
      puts "inserted"
      return false
    end
       
    if (aStat.status !=0 )
      return true
    else
      return false      
    end
  end # end of function
  

  def updateAstatus(art, status, process_type)
    if (process_type == "similar artists")
      aStat = AStat.find(:first, :conditions =>["altnet_id = ?", art.id])
    elsif (process_type == "similar tracks")
      aStat = AggregateSimilarTracksStat.find(:first, :conditions =>["altnet_id = ?", art.id])
    end
    
    
    
    aStat.status = status
    
    aStat.save   
  end

end
