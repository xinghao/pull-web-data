require 'hpricot'
class LastfmDataSourceHandler < DataSource
    def initialize
      @DataSourceType = "lastfm"  
      @ReDoAll = false
      @ReDoError = false
      @ReDo1 = false
      @ReDo2 = false
      @ReDo3 = false
      @ReDo4 = true 
      @ReDo5 = false 
      @ReDo = [0,0,0,0,0,0,0]      
    end

  def getTrackPopularityFromSimilarTracksData iStart, offset
    where = @DataSourceType+ " = ? and altnet_id >= ? and altnet_id < ?"
    SimilarPTrackStat.find(:all, :order=>"altnet_id", :conditions =>[where , 5 , iStart, (offset+iStart)]).each do |ps|
        track = Track.find(:first, :conditions =>["id = ?", ps.altnet_id])
        puts @DataSourceType + " analyzing(raw data) :" + ps.id.to_s + "-" + track.id.to_s
    
        begin
          status = analyzePopularityFromSimilarTracksDataImp(track)    
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

  
  def getSimilarArtistWebRawData artist
        rw = RawWebData.new
        
        begin
          
          retStr = rw.getLastFmWebData(artist.name)
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceLastfm.new
          wlf.altnet_id = artist.id
          wlf.html = html.to_s
          wlf.url = rw.getLastFmWebDataUrl(artist.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end 
    
  end
  
  
  
  def getSimilarTrackWebRawDataImp track
        rw = RawWebData.new
        
        begin
          # album = track.album;
          # if (album == nil) 
          #   return 11
          # end                   
          artist = track.artist;
          if (artist == nil) 
            return 11
          end

          
          retStr = rw.getLastFmSimilarTrackData(artist.name, "", track.name)
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceTrackSimilarLastfm.new
          wlf.altnet_id = track.id
          wlf.html = html.to_s
          wlf.url = rw.getLastFmSimilarTrackDataUrl(artist.name, "", track.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end 
  
  end
  
  def getPopularArtistWebRawDataImp artist
        rw = RawWebData.new
        
        begin
          
          retStr = rw.getLastfmArtistPopularity(artist.name)
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceArtistPopularLastfm.new
          wlf.altnet_id = artist.id
          wlf.html = html.to_s
          wlf.url = rw.getLastfmArtistPopularityUrl(artist.name)
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

  def analyzeSimilarTrackRawDataImp track
    websource = WebsourceTrackSimilarTemplastLastfm.find(:first, :conditions =>["altnet_id = ?", track.id], :order => "id desc")
    #websource = WebsourceTrackSimilarLastfm.find(:first, :conditions =>["altnet_id = ?", track.id], :order => "id desc")
    #puts websource.html
    document = Hpricot(websource.html.to_s)
    sarts = document.search("tr").search("//td[@class='subjectCell']")
    
    #RelateMtv.delete_all(:altnet_id => art.id)
    
    icount = 0
    ifound = 0
    sarts.each do |sart|
      #puts sart
      #puts sart
      regex = Regexp.new(/>(.*)<\/a>.*>(.*)<\/a>/)
      matchdata = regex.match(sart.to_s)
      #print matchdata
      icount = icount + 1
      
      if matchdata
        #similar_artist_name = matchdata[1]
        #puts matchdata[1]  + " - " + matchdata[2]
        ifound = ifound + insertSimilarTrack(track.id, CGI.unescapeHTML(matchdata[1]), "", CGI.unescapeHTML(matchdata[2]), icount)
        #puts similar_artist_name   
      end
    end #end of iteration of artists 
    puts ifound
    
    if (ifound > 0)
      return 12
    else
      return 6
    end
    
  end # end of function    
  
  def analyzeSimilarArtistRawData art
    document = Hpricot(art.websource_lastfm.html.to_s)
    sarts = document.search("li").search("a").search("strong")
    
    
    #RelateMtv.delete_all(:altnet_id => art.id)
    
    icount = 0
    ifound = 0
    sarts.each do |sart|
      #puts sart
      regex = Regexp.new(/<strong>(.*)<\/strong>/)
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


  def analyzePopularArtistRawData art
    document = Hpricot(art.websource_artist_popular_lastfm.html.to_s)
    sarts = document.search("p");
    
    #puts sarts
    #RelateMtv.delete_all(:altnet_id => art.id)
    regex = Regexp.new(/\((.*) listeners\)/)
    matchdata = regex.match(sarts.to_s)
    
    
    if (matchdata != nil)      
      insertArtistPopularity(art.id,matchdata[1].gsub(",", "").to_i)
      puts matchdata[1].gsub(",", "").to_i
      return 1
    else
      puts "no match";
      return 6
    end
  end #end of function



  def analyzePopularAlbumRawData album
    document = Hpricot(album.websource_album_popular_lastfm.html.to_s)
    sarts = document.search("p");
    
    #puts sarts
    #RelateMtv.delete_all(:altnet_id => art.id)
    regex = Regexp.new(/\((.*) listeners\)/)
    matchdata = regex.match(sarts.to_s)
    
    
    if (matchdata != nil)      
      insertAlbumPopularity(album.id,matchdata[1].gsub(",", "").to_i)
      puts matchdata[1].gsub(",", "").to_i
      return 1
    else
      puts "no match";
      return 6
    end
  end #end of function


  def getPopularAlbumWebRawDataImp album
        rw = RawWebData.new
        
        begin
          artist_name = ""
          artist = album.artist;
          if (artist != nil)
            artist_name = artist.name
          end
              
          retStr = rw.getLastfmAlbumPopularity(artist_name, album.name)
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceAlbumPopularLastfm.new
          wlf.altnet_id = album.id
          wlf.html = html.to_s
          wlf.url = rw.getLastfmAlbumPopularityUrl(artist_name, album.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end
  end #end of function

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
              
          retStr = rw.getLastfmTrackPopularity(artist_name, "", track.name)
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceTrackPopularLastfm.new
          wlf.altnet_id = track.id
          wlf.html = html.to_s
          wlf.url = rw.getLastfmTrackPopularityUrl(artist_name, track.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end
  end #end of function
  
  
  def analyzePopularityFromSimilarTracksDataImp track
    websource = WebsourceTrackSimilarTemp050100Lastfm.find(:first, :conditions =>["altnet_id = ?", track.id], :order => "id desc")
    #websource = WebsourceTrackSimilarLastfm.find(:first, :conditions =>["altnet_id = ?", track.id], :order => "id desc")
    #puts websource.html
    if (websource != nil)
      document = Hpricot(websource.html.to_s)
      sarts = document.search("tr")
      
      #RelateMtv.delete_all(:altnet_id => art.id)
      
      icount = 0
      ifound = 0
      sarts.each do |sart|
        #puts sart
        #puts sart
        regex = Regexp.new(/>(.*)<\/a>.*>(.*)<\/a>/)
        matchdata = regex.match(sart.to_s)
        regex1 = Regexp.new(/reachCell">(.*)<\/td>/m)
        matchdata1 = regex1.match(sart.to_s)
        
        #print matchdata
        icount = icount + 1
        
        if (matchdata1)
          #similar_artist_name = matchdata[1]
          #puts matchdata[1]  + " - " + matchdata[2] + ":" + matchdata1[1].strip.gsub(",", "")
          ifound = ifound + insertPopularTrackFromSimilarTrack(track.id, CGI.unescapeHTML(matchdata[1]), "", CGI.unescapeHTML(matchdata[2]), icount, matchdata1[1].strip.gsub(",", ""))
          #puts similar_artist_name   
        end
      end #end of iteration of artists 
      puts ifound
      
      if (ifound > 0)
        return 12
      else
        return 6
      end
    end
    return 6
  end # end of function    
  
  
  def insertPopularTrackFromSimilarTrack(track_id, artist_name, album_name, track_name, icount, popularity)
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
    rm = PopularTracksLastfmTemp.new
    
    rm.altnet_id = track.id
    rm.lastfm = popularity
    rm.version = 1
    rm.save
    return 1
  end

  def analyzePopularTrackRawDataImpl track
    document = Hpricot(track.websource_track_popular_lastfm.html.to_s)
    sarts = document.search("div");
    
    #puts sarts
    #RelateMtv.delete_all(:altnet_id => art.id)
    regex = Regexp.new(/container listeners.*<span>(.*)<\/span>/m)
    matchdata = regex.match(sarts.to_s)
    
    
    if (matchdata != nil)
      insertTrackPopularity(track.id, matchdata[1].gsub(",", "").to_i, nil,nil,nil,nil,nil)      
      puts matchdata[1].gsub(",", "").to_i
      return 1
    else
      puts "no match";
      return 6
    end
    
  end #end of function
  
  # def insertPopularTrackFromSimilarTrack(version)
  #   PopularTracksLastfmTempA.find(:all).each do |p|
  #     PopularTracksLastfmTempA.find(:first, :conditions =>[ "artist_id = ? and is_valid = 1 and name = ?",])      
  #   end
  # end
  
  def checkArtistPopularWrongData
   where = @DataSourceType+ " = ?"
   iOffset = 0
   # iOffset = 30000
   # iOffset = 60000
   # iOffset = 90000
   # iOffset = 120000
   iLimit = 10    
    #PopularPStat.find(:all, :conditions =>[where , 5 ], :offset => iOffset, :limit => iLimit).each do |ps|
    PopularPStat.find(:all, :conditions =>[where , 1 ]).each do |ps|
    #PopularPStat.find(:all, :conditions =>["altnet_id = ?" , 1785 ]).each do |ps|
    #PStat.find(:all, :conditions =>[where , 5 ]).each do |ps|
      art = Artist.find(:first, :conditions =>["id = ?", ps.altnet_id])
      puts @DataSourceType + " analyzing(raw data) :" + art.id.to_s
  
      begin
        status = analyzePopularArtistWrongData(art)    
      rescue Exception => e
        puts e
        status = 7
      end 
      
      begin
        puts "status : "+ status.to_s
        if status != 0 then
          ps.lastfm_wrong = status;
          ps.save
        end
      rescue Exception => e
        puts e
      end 
    end #end of iteration    
    return 0

  end
  
  def analyzePopularArtistWrongData art
    document = Hpricot(art.websource_artist_popular_lastfm.html.to_s)
    sarts = document.search("p");
    
    #puts sarts
    #RelateMtv.delete_all(:altnet_id => art.id)
    regex = Regexp.new(/music\/(.*)" id/)
    matchdata = regex.match(sarts.to_s)
    
    
    if (matchdata != nil)      
      #insertArtistPopularity(art.id,matchdata[1].gsub(",", "").to_i)
      match_name =  matchdata[1].gsub("+", " ").gsub("the ", "").gsub("The ", "");
      #puts match_name;
      artist_name = art.name.gsub("the ", "").gsub("The ", "");      
      if (artist_name != match_name and artist_name.length >= match_name.length + 1)
        return 1
      else
        return 0
      end
    else
      puts "no match";
      return 66
    end
  end #end of function
  
end
