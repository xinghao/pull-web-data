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
  
  
# select * from artists,popular_artists where artists.id = popular_artists.artist_id and name like '%james%' order by popularity desc
# select * from artists where  name like '%james%' order by external_popularity desc
# select * from artists where  name like '%james%' and type = 'person' order by aggregated_popularity desc
# select * from popular_artists where artist_id = 106267
# select * from popular_artists where artist_id = 6938
# update artists set external_popularity = external_popularity/5 where type = 'group';
# update artists set external_popularity = external_popularity/10 where type is null;
# select * from artists where name = 'james brown'
# select * from 
  
  #update popular_artists set lastfm = 0 where echonest is null;
  #select max(lastfm) from popular_artists
  #update popular_artists set popularity=lastfm/3150173;
  #update popular_artists set echonest = 0 where echonest is null;
  #update popular_artists set popularity=(lastfm*0.2)/3150173 + echonest*0.2;
  #update artists set external_popularity = (0.6*tracks_play_count)/402659.0;
  #update artists a, popular_artists p set a.external_popularity = a.external_popularity + p.popularity where a.id = p.artist_id;
  #update artists set aggregated_popularity = aggregated_popularity / 5 where (name like '% and %' or name like '% & %' or name like ' with ' ) and name != 'Brooks & Dunn' and name !='Tuck & Patti'
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
  
  def analyzeAlbumPopularRowData
    where = @DataSourceType+ " = ?"
   iOffset = 0
   iLimit = 10    
   #PopularPStat.find(:all, :conditions =>[where , 5 ], :offset => iOffset, :limit => iLimit).each do |ps|
   PopularPAlbumStat.find(:all, :conditions =>[where , 5 ]).each do |ps|
    #PStat.find(:all, :conditions =>[where , 5 ]).each do |ps|
      album = Album.find(:first, :conditions =>["id = ?", ps.altnet_id])
      puts @DataSourceType + " analyzing(raw data) :" + album.id.to_s
  
      begin
        status = analyzePopularAlbumRawData(album)    
      rescue Exception => e
        puts e
        status = 7
      end 
      
      begin
        puts "status : "+ status.to_s
        updatePstatus("album popular", @DataSourceType, status, album.id)
      rescue Exception => e
        puts e
      end 
    end #end of iteration    
    return 0
  end # end of function
  
  def getWebRawArtistPopularData(iOffset, iLimit)
    where = @DataSourceType+ " = ?"
   #art = Artist.find(1785)
   icount = 0
   iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   iLimit = 30000
   Artist.find(:all, :offset => iOffset, :limit => iLimit).each do |art|
   #PopularPStat.find(:all, :offset => iOffset, :limit => iLimit, :order=>"id", :conditions =>[where , 0 ]).each do |ps|
     art = Artist.find(ps.altnet_id)
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

  def getWebRawTrackPopularData(iOffset, iLimit)
   #track = Track.find(:first)
   icount = 0
   #iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   #iLimit = 30000
   Track.find(:all, :offset => iOffset, :limit => iLimit).each do |track|
        puts @DataSourceType + " processing(track popular raw data) :" + track.id.to_s
        if (!alreadyHandled("track popular", @DataSourceType, @ReDo, track.id)) then
          status = getPopularTrackWebRawDataImp(track)
          #status = 9
          puts "status : "+ status.to_s
          updatePstatus("track popular", @DataSourceType, status, track.id)
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
        if (!alreadyHandled("similar tracks", @DataSourceType, @ReDo, track.id)) then
          status = getSimilarTrackWebRawDataImp(track)
          #status = 9
          puts "status : "+ status.to_s
          updatePstatus("similar tracks", @DataSourceType, status, track.id)
        end
   end #--end of album iteration 
  end
  
    def analyzeSimilarTrackRawData iStart, offset
    where = @DataSourceType+ " = ? and altnet_id >= ? and altnet_id < ?"
    #SimilarPTrackStat.find(:all, :conditions =>[where , 5 ], :offset => iOffset, :limit => iLimit).each do |ps|
    SimilarPTrackStat.find(:all, :order=>"altnet_id", :conditions =>[where , 5 , iStart, (offset+iStart)]).each do |ps|
#    SimilarPTrackStat.find(:all, :conditions =>["lastfm = 5 and mtv =5 "], :offset => iOffset, :limit => iLimit).each do |ps|
#      SimilarPTrackStat.find(:all, :conditions =>["lastfm = 5 and mtv =5 "]).each do |ps|
        track = Track.find(:first, :conditions =>["id = ?", ps.altnet_id])
        puts @DataSourceType + " analyzing(raw data) :" + ps.id.to_s + "-" + track.id.to_s
    
        begin
          status = analyzeSimilarTrackRawDataImp(track)    
        rescue Exception => e
          puts e
          status = 7
        end 
        
        begin
          puts "status : "+ status.to_s
          #updatePstatus("similar tracks", @DataSourceType, status, track.id)
        rescue Exception => e
          puts e
        end 
    end #end of iteration    
    return 0
  end # end of function

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
 
  def insertSimilarTrack(track_id, artist_name, album_name, track_name, icount)
    #puts "artist name:" + artist_name
    artist = Artist.find(:first, :conditions =>[ "name = ? and is_valid = 1", artist_name ])
    if artist == nil
      return 0
    end
    
    #puts "track name:" + track_name
    track = Track.find(:first, :conditions =>[ "artist_id = ? and is_valid = 1 and name = ?", artist.id, track_name])
    if track == nil
      return 0
    end
    #puts "match!"
    if @DataSourceType == "lastfm"
      rm = SimilarTrackLastfm.new 
    elsif @DataSourceType == "mtv"
      rm = SimilarTrackMtv.new
    end 
    
    rm.altnet_id = track_id
    rm.similar_artist_id = artist.id
    rm.similar_track_id = track.id           
    rm.score = icount 
    rm.save
    return 1
  end
  
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

  def insertAlbumPopularity(album_id, popularity)
    popular = PopularAlbum.find_by_album_id(album_id)
    if (popular == nil)
      popular = PopularAlbum.new
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
    
    popular.album_id = album_id
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
    elsif (process_type == "similar tracks")
      pStat = SimilarPTrackStat.find_by_altnet_id(id)
    elsif (process_type == "track popular")
      pStat = PopularPTrackStat.find_by_altnet_id(id)       
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
    elsif (process_type == "track popular")
      pStat = PopularPTrackStat.find_by_altnet_id(id) 
    elsif (process_type == "similar tracks")
      pStat = SimilarPTrackStat.find_by_altnet_id(id)
    end
    
    if (pStat == nil) 

      if (process_type == "similar artists")
        pStat =  PStat.new
      elsif (process_type == "artist popular")
        pStat = PopularPStat.new
      elsif (process_type == "album popular")
        pStat = PopularPAlbumStat.new 
      elsif (process_type == "track popular")
        pStat = PopularPTrackStat.new         
      elsif (process_type == "similar tracks")
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
