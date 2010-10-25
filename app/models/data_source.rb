class DataSource
  
  def initialize
    @DataSourceType = ""  
    @ReDoAll = false
    @ReDoError = false
    @ReDo1 = false
    @ReDo2 = false
    @ReDo3 = false
    @ReDo4 = false
    @ReDo5 = false
    @ReDo = [0,0,0,0,0,0,0]
  end
  
  #update popular_artists set lastfm = 0 where echonest is null;
  #select max(lastfm) from popular_artists
  #update popular_artists set popularity=lastfm/3150173;
  #update popular_artists set echonest = 0 where echonest is null;
  #update popular_artists set popularity=(lastfm*0.8)/3150173 + echonest*0.2;
  def analyzeArtistPopularRowData
    #art = Artist.find(1)
    where = @DataSourceType+ " = ?"
   iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   iLimit = 10    
    #PopularPStat.find(:all, :conditions =>[where , 5 ], :offset => iOffset, :limit => iLimit).each do |ps|
    PopularPStat.find(:all, :conditions =>[where , 5 ]).each do |ps|
    #PStat.find(:all, :conditions =>[where , 5 ]).each do |ps|
      art = Artist.find(:first, :conditions =>["id = ?", ps.altnet_id])
      puts @DataSourceType + " analyzing(raw data) :" + art.id.to_s
  
      begin
        status = analyzePopularArtistRawData(art)    
      rescue Exception => e
        puts e
        status = 7
      end 
      
      begin
        puts "status : "+ status.to_s
        art.updatePstatus("artist popular", @DataSourceType, status)
      rescue Exception => e
        puts e
      end 
    end #end of iteration    
    return 0
  end # end of function
  
  
  def getWebRawArtistPopularData
   #art = Artist.find(1785)
   icount = 0
   iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   iLimit = 30000
   Artist.find(:all, :offset => iOffset, :limit => iLimit).each do |art|
      puts @DataSourceType + " processing(artist popularity raw data) :" + art.id.to_s
      if (!alreadyHandled("artist popular", @DataSourceType, @ReDo, art.id)) then
        status = getPopularArtistWebRawDataImp(art)
        #status = 9
        puts "status : "+ status.to_s
        updatePstatus("artist popular", @DataSourceType, status, art.id)
      end
      
   end #--end of artist iteration 
  end
  
  
  def getWebRawAlbumPopularData(iOffset, iLimit)
   #album = Album.find(1)
   icount = 0
   #iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   #iLimit = 30000
   Album.find(:all, :offset => iOffset, :limit => iLimit).each do |album|
        puts @DataSourceType + " processing(album popularity raw data) :" + album.id.to_s
        if (!alreadyHandled("album popular", @DataSourceType, @ReDo, album.id)) then
          status = getPopularAlbumWebRawDataImp(album)
          #status = 9
          puts "status : "+ status.to_s
          updatePstatus("album popular", @DataSourceType, status, album.id)
        end
   end #--end of album iteration 
  end

  def getWebRawSimilarTrackData(iOffset, iLimit)
   #album = Album.find(1)
   icount = 0
   #iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   #iLimit = 30000
   Track.find(:all, :offset => iOffset, :limit => iLimit).each do |track|
        puts @DataSourceType + " processing(similar track raw data) :" + track.id.to_s
        if (!alreadyHandled("similar track", @DataSourceType, @ReDo, track.id)) then
          status = getSimilarTrackWebRawDataImp(track)
          #status = 9
          puts "status : "+ status.to_s
          updatePstatus("similar track", @DataSourceType, status, track.id)
        end
   end #--end of album iteration 
  end
  
  
  def analyzeRowData
    #art = Artist.find(1)
    where = @DataSourceType+ " = ?"
   iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   iLimit = 10    
    PStat.find(:all, :conditions =>[where , 5 ], :offset => iOffset, :limit => iLimit).each do |ps|
    #PStat.find(:all, :conditions =>[where , 5 ]).each do |ps|
      art = Artist.find(:first, :conditions =>["id = ?", ps.altnet_id])
      puts @DataSourceType + " analyzing(raw data) :" + art.id.to_s
  
      begin
        status = analyzeSimilarArtistRawData(art)    
      rescue Exception => e
        puts e
        status = 7
      end 
      
      begin
        puts "status : "+ status.to_s
        updatePstatus(art.id, status)
      rescue Exception => e
        puts e
      end 
    end #end of iteration    
    return 0
  end # end of function
  
  
  
  
  def getWebRawData
    #2402 the rolling stones
    #1785 beyonce
    #2190 the black eyed peas
    #2   Doves
   #art = Artist.find(36)
   icount = 0
   iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   iLimit = 10
   Artist.find(:all, :offset => iOffset, :limit => iLimit).each do |art|
      puts @DataSourceType + " processing(raw data) :" + art.id.to_s
      if (!alreadyHandled("similar artists", @DataSourceType, @ReDo, art.id)) then
        status = getSimilarArtistWebRawData(art)
        
        puts "status : "+ status.to_s
        updatePstatus("similar artists", @DataSourceType, status,art.id)
      end
      # icount = icount + 1
      # if (icount > 10)
      #   break
      # end
      
    end # end of artist iteration
  end # end of getWebRawData()
    
  
  # control the whole process to get data
  def getData  
   #art = Artist.find(2402)
    Artist.all.each do |art|
      puts @DataSourceType + " processing :" + art.id.to_s
      if (!alreadyHandled(art.id)) then
        status = getSimilarArtistId(art)
        puts "status : "+ status.to_s
        updatePstatus(art.id, status)
      end
      #break
      
    end # end of artist iteration
  end # end of getData()
  
  # updated status after handled
  # def updatePstatus(altnet_id, status)
  #   pStat = PStat.find_by_altnet_id(altnet_id)
  #   if @DataSourceType == "mz"
  #     pStat.mz = status
  #   elsif @DataSourceType == "lastfm"
  #     pStat.lastfm = status 
  #   elsif @DataSourceType == "echonest"
  #     pStat.echonest = status
  #   elsif @DataSourceType == "yahoomusic"
  #     pStat.yahoomusic = status
  #   elsif @DataSourceType == "mtv"
  #     pStat.mtv = status 
  #   end   
  #     pStat.save   
  # end
  # 
  # # check if this artist has already been handled
  # def alreadyHandled altnet_id
  #   pStat = PStat.find_by_altnet_id(altnet_id)
  #   if (pStat == nil) 
  #     pStat =  PStat.new
  #     pStat.altnet_id = altnet_id
  #     pStat.mz = 0
  #     pStat.lastfm = 0
  #     pStat.echonest = 0
  #     pStat.yahoomusic = 0
  #     pStat.mtv = 0
  #     pStat.save
  #     return false
  #   end
  #   
  #   if @ReDoAll
  #     return false
  #   end
  #   
  #   status=0
  #   if @DataSourceType == "mz"
  #     status = pStat.mz
  #   elsif @DataSourceType == "lastfm"
  #     status = pStat.lastfm 
  #   elsif @DataSourceType == "echonest"
  #     status = pStat.echonest 
  #   elsif @DataSourceType == "yahoomusic"
  #     status = pStat.yahoomusic 
  #   elsif @DataSourceType == "mtv"
  #     status = pStat.mtv 
  #   end
  #        puts "status:" + status.to_s
  #        puts "redo4:" + @ReDo4.to_s
  #     if ((status != 1 or status != 5) and @ReDoError) 
  #       puts "good1"
  #       return false
  #     elsif (status == 1 and @ReDo1)
  #       puts "good2"
  #       return false
  #     elsif (status == 2 and @ReDo2)
  #       puts "good3"
  #       return false
  #     elsif (status == 3 and @ReDo3)
  #       puts "good4"
  #       return false
  #     elsif (status == 4 and @ReDo4)
  #       puts "good5"
  #       return false
  #     elsif (status == 5 and @ReDo5)
  #       puts "good6"
  #       return false        
  #     elsif (status != 0)
  #       puts "good7" 
  #       return true
  #     else 
  #       return false
  #     end      
  # end # end of function
 
 
  def insertSimilarArtist(art_id, similar_artist_name, icount)
    similar_artist = Artist.find(:first, :conditions =>[ "name = ?", similar_artist_name ])

    if similar_artist == nil
      return 0
    end
    

    if @DataSourceType == "lastfm"
      rm = RelateLastfm.new 
    elsif @DataSourceType == "echonest"
      rm = RelateEchonest.new 
    elsif @DataSourceType == "yahoomusic"
      rm = RelateYahoomusic.new 
    elsif @DataSourceType == "mtv"
      rm = RelateMtv.new
    end 
    
    rm.altnet_id = art_id
    rm.similar_artist_id = similar_artist.id       
    rm.position = icount
    rm.score = icount 
    rm.save
    
    return 1      
  end


  def insertArtistPopularity(art_id, popularity)
    popular = PopularArtist.find_by_artist_id(art_id)
    if (popular == nil)
      popular = PopularArtist.new
    end
            
    if @DataSourceType == "lastfm"
      popular.lastfm = popularity 
    elsif @DataSourceType == "echonest"
      popular.echonest = popularity 
    elsif @DataSourceType == "yahoomusic"
      popular.yahoomusic = popularity 
    elsif @DataSourceType == "mtv"
      popular.mtv = popularity
    end 
    
    popular.artist_id = art_id
    popular.save
    
    return 1      
  end

  


  def updatePstatus(process_type, data_source_type, status, id)
    if (process_type == "similar artists")
      pStat = PStat.find_by_altnet_id(id)
    elsif (process_type == "artist popular")
      pStat = PopularPStat.find_by_altnet_id(id)
    elsif (process_type == "album popular")
      pStat = PopularPAlbumStat.find_by_altnet_id(id)
    elsif (process_type == "similar artists")
      pStat = SimilarPTrackStat.find_by_altnet_id(id)
    end
    
    if data_source_type == "mz"
      pStat.mz = status
    elsif data_source_type == "lastfm"
      pStat.lastfm = status 
    elsif data_source_type == "echonest"
      pStat.echonest = status
    elsif data_source_type == "yahoomusic"
      pStat.yahoomusic = status
    elsif data_source_type == "mtv"
      pStat.mtv = status 
    end   
      pStat.save   
  end
  
  # check if this artist has already been handled
  def alreadyHandled(process_type,data_source_type,reDo, id)
    if (process_type == "similar artists")
      pStat = PStat.find_by_altnet_id(id)
    elsif (process_type == "artist popular")
      pStat = PopularPStat.find_by_altnet_id(id)
    elsif (process_type == "album popular")
      pStat = PopularPAlbumStat.find_by_altnet_id(id) 
    elsif (process_type == "similar artists")
      pStat = SimilarPTrackStat.find_by_altnet_id(id)
    end
    
    if (pStat == nil) 

      if (process_type == "similar artists")
        pStat =  PStat.new
      elsif (process_type == "artist popular")
        pStat = PopularPStat.new
      elsif (process_type == "album popular")
        pStat = PopularPAlbumStat.new 
      elsif (process_type == "similar artists")
        pStat = SimilarPTrackStat.new               
      end
      
      pStat.altnet_id = id
      pStat.mz = 0
      pStat.lastfm = 0
      pStat.echonest = 0
      pStat.yahoomusic = 0
      pStat.mtv = 0
      pStat.save
      return false
    end
    
    if (reDo[0] == 1)
      return false
    end
    
    status=0
    if data_source_type == "mz"
      status = pStat.mz
    elsif data_source_type == "lastfm"
      status = pStat.lastfm 
    elsif data_source_type == "echonest"
      status = pStat.echonest 
    elsif data_source_type == "yahoomusic"
      status = pStat.yahoomusic 
    elsif data_source_type == "mtv"
      status = pStat.mtv 
    end

      if ((status != 1 or status != 5) and reDo[1] == 1) 
        puts "good1"
        return false
      elsif (status == 1 and reDo[2] == 1)
        puts "good2"
        return false
      elsif (status == 2 and reDo[3] == 1)
        puts "good3"
        return false
      elsif (status == 3 and reDo[4] == 1)
        puts "good4"
        return false
      elsif (status == 4 and reDo[5] == 1)
        puts "good5"
        return false
      elsif (status == 5 and reDo[6] == 1)
        puts "good6"
        return false        
      elsif (status != 0)
        puts "good7" 
        return true
      else 
        return false
      end      
  end # end of function
       
end
