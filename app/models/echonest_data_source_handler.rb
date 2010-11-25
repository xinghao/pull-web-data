require 'hpricot'
class EchonestDataSourceHandler < DataSource
    def initialize
      @DataSourceType = "echonest"  
      @ReDoAll = false
      @ReDoError = false
      @ReDo1 = false
      @ReDo2 = false
      @ReDo3 = false
      @ReDo4 = false 
      @ReDo5 = false       
      @ReDo = [0,0,0,0,0,0,0]
    end

  def getSimilarArtistWebRawData artist
        rw = RawWebData.new
        
        begin
          
          retStr = rw.getEchonest(artist.music_brainz_id,artist.name)
          
          html = ""
          if (retStr.to_s.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          WebsourceEchonest.delete_all(:altnet_id => artist.id) 
          wlf = WebsourceEchonest.new
          wlf.altnet_id = artist.id
          wlf.html = html.to_s
          wlf.url = rw.getEchonestUrl(artist.music_brainz_id,artist.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end 
    
  end
  
  
  def getSimilarArtistId artist
      
 
  end #end of function 
  
  
  def analyzeSimilarArtistRawData art
    document = Hpricot(art.websource_echonest.html.to_s)
    sarts = document.search("artist").search("name")
    
    
    #RelateMtv.delete_all(:altnet_id => art.id)
    
    icount = 0
    ifound = 0
    sarts.each do |sart|
      #puts sart
      regex = Regexp.new(/<name>(.*)<\/name>/)
      matchdata = regex.match(sart.to_s)
      
      icount = icount + 1
      
      if matchdata
        similar_artist_name = matchdata[1]         
       ifound = ifound + insertSimilarArtist(art.id, similar_artist_name, icount)
        #puts similar_artist_name           
      end
      
    end #end of iteration of artists 
    
    if (ifound > 0)
      return 1
    else
      return 6
    end
  end #end of function

  def getPopularArtistWebRawDataImp artist
        rw = RawWebData.new
        
        begin
          
          retStr = rw.getEchonestArtistPopularData(artist.music_brainz_id, artist.name).to_s
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceArtistPopularEchonest.new
          wlf.altnet_id = artist.id
          wlf.html = html
          wlf.url = rw.getEchonestArtistPopularUrl(artist.music_brainz_id, artist.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end 
    
  end
  
  def getPopularTrackWebRawDataImp track
        rw = RawWebData.new
        
        begin
          artist_name = ""
          artist = track.artist;
          if (artist != nil)
            artist_name = artist.name
          else
            return 11
          end

          retStr = rw.getEchonestTrackPopularity(artist_name, "", track.name).to_s()
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceTrackPopularEchonest.new
          wlf.altnet_id = track.id
          wlf.html = html
          wlf.url = rw.getEchonestTrackPopularityUrl(artist_name, track.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end 
    
  end
  
  def analyzePopularArtistRawData art
    document = Hpricot(art.websource_artist_popular_echonest.html.to_s)
    sarts = document.search("hotttnesss");
    
    #puts sarts
    #RelateMtv.delete_all(:altnet_id => art.id)
    regex = Regexp.new(/<hotttnesss>(.*)<\/hotttnesss>/)
    matchdata = regex.match(sarts.to_s)
    
    
    if (matchdata != nil)      
      insertArtistPopularity(art.id,matchdata[1].gsub(",", ""))
      puts matchdata[1]
      return 1
    else
      puts "no match";
      return 6
    end
  end #end of function
  
  def analyzePopularTrackRawDataImpl track
    document = Hpricot(track.websource_track_popular_echonest.html.to_s)
    #sarts = document.search("p");
    
    #puts sarts
    #RelateMtv.delete_all(:altnet_id => art.id)
    regex_hot = Regexp.new(/<song_hotttnesss>(.*)<\/song_hotttnesss>/)
    regex_energy = Regexp.new(/<energy>(.*)<\/energy>/)
    regex_tempo = Regexp.new(/<tempo>(.*)<\/tempo>/)
    regex_duration = Regexp.new(/<duration>(.*)<\/duration>/)
    regex_loudness = Regexp.new(/<loudness>(.*)<\/loudness>/)
    regex_danceability = Regexp.new(/<danceability>(.*)<\/danceability>/)
    matchdata_hot = regex_hot.match(document.to_s)
    matchdata_energy = regex_energy.match(document.to_s)
    matchdata_tempo = regex_tempo.match(document.to_s)
    matchdata_duration = regex_duration.match(document.to_s)
    matchdata_loudness = regex_loudness.match(document.to_s)
    matchdata_danceability = regex_danceability.match(document.to_s)
    
    hot = nil;
    energy = nil;
    temp = nil;
    duration = nil;
    loudness = nil;
    danceability = nil;
    if (matchdata_hot != nil)
      hot = matchdata_hot[1]
    end
    if (matchdata_tempo != nil)
      tempo = matchdata_tempo[1]
    end
    if (matchdata_duration != nil)
      duration = matchdata_duration[1]
    end
    if (matchdata_loudness != nil)
      loudness = matchdata_loudness[1]
    end
    if (matchdata_danceability != nil)
      danceability = matchdata_danceability[1]
    end
    if (matchdata_energy != nil)
      energy = matchdata_energy[1]
    end
    
    
    if (hot != nil or tempo != nil or duration != nil or loadness != nil or danceability != nil or enery != nill)      
      insertTrackPopularity(track.id, hot, energy, tempo, duration, loudness, danceability)
      return 1
    else
      puts "no match";
      return 6
    end
  end #end of function
  
end
