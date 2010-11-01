class Aggregator
    def initialize
    end

  def aggredateSimilarTracks iOffset, iLimit
    tracks = SimilarPTrackStat.find(:all, :offset => iOffset, :limit => iLimit, :conditions =>["mtv = 5 and lastfm = 5"])
    tracks.each do |track|
      
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
  
  
  # check if this artist has already been handled
  def alreadyHandled art
    aStat = art.a_stat
    if (aStat == nil) 
      aStat =  AStat.new
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
  

  def updateAstatus(art, status)
    aStat = AStat.find(:first, :conditions =>["altnet_id = ?", art.id])
    
    aStat.status = status
    
    aStat.save   
  end

end
