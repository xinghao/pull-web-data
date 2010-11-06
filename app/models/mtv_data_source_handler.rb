require 'hpricot'
class MtvDataSourceHandler < DataSource
    def initialize
      @DataSourceType = "mtv"  
      @ReDoAll = false
      @ReDoError = false
      @ReDo1 = false
      @ReDo2 = false
      @ReDo3 = false
      @ReDo4 = false 
      @ReDo5 = false  
      @ReDo = [0,0,0,0,0,0,0]   
    end


  # def analyzeSimilarTrackRawData track
  #   document = Hpricot(track.websource_track_similar_lastfm.html.to_s)
  #   sarts = document.search("tr").search("//td[@class='subjectCell']")
  #   
  #   
  #   #RelateMtv.delete_all(:altnet_id => art.id)
  #   
  #   icount = 0
  #   ifound = 0
  #   sarts.each do |sart|
  #     #puts sart
  #     #puts sart
  #     regex = Regexp.new(/>(.*)<\/a>.*>(.*)<\/a>/)
  #     matchdata = regex.match(sart.to_s)
  #     #print matchdata
  #     icount = icount + 1
  #     
  #     if matchdata
  #       #similar_artist_name = matchdata[1]
  #       #puts matchdata[1]  + " - " + matchdata[2]
  #       #ifound = ifound + insertSimilarArtist(art.id, similar_artist_name, icount)
  #       #ifound = ifound + insertSimilarTrack(track.id, matchdata[1], "", matchdata[2], icount)
  #       #puts similar_artist_name           
  #     end
  #   end #end of iteration of artists 
  #   
  #   if (ifound > 0)
  #     return 1
  #   else
  #     return 6
  #   end
  # end # end of function    


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

          
          retStr = rw.getPandoraSimilarTrackData(artist.name, "", track.name)
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          #WebsourceLastfm.delete_all(:altnet_id => artist.id)
          #artist.websource_lastfm.remove 
          wlf = WebsourceTrackSimilarMtv.new
          wlf.altnet_id = track.id
          wlf.html = html.to_s
          wlf.url = rw.getPandoraSimilarTrackDataUrl(artist.name, "", track.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end 
  
  end


  def getSimilarArtistWebRawData artist
        rw = RawWebData.new
        
        begin
          
          retStr = rw.getMtvData(artist.name)
          
          html = ""
          if (retStr.empty?)
            status = 2
           else
             html = retStr
            status = 5
          end

          WebsourceMtv.delete_all(:altnet_id => artist.id) 
          wlf = WebsourceMtv.new
          wlf.altnet_id = artist.id
          wlf.html = html.to_s
          wlf.url = rw.getMtvDataUrl(artist.name)
          #wlf.url = ""
          wlf.save
          
          return status 
            
          
        rescue Exception => e
          puts e
          status = 4
          return status
        end 
    
  end
  
  
  
  def analyzeSimilarArtistRawData art
    document = Hpricot(art.websource_mtv.html.to_s)
    sarts = document.search("a")
    
    
    RelateMtv.delete_all(:altnet_id => art.id)
    
    icount = 0
    ifound = 0
    sarts.each do |sart|
      regex = Regexp.new(/\/>(.*)<\/a>/)
      matchdata = regex.match(sart.to_s)
      
      icount = icount + 1
      
      if matchdata
        similar_artist_name = matchdata[1]         
        ifound = ifound + insertSimilarArtist(art.id, similar_artist_name, icount)        
      end
      
    end #end of iteration of artists 
    
    # icount = 0
    # keys = h.keys
    # if (keys.length > 0)
    #   puts keys.join(",")
    #   #before doing anything clean the table
    #   RelateMtv.delete_all(:altnet_id => art.id)
    #   
    #   Artist.find(:all, :conditions =>[ "name in (?)", keys.join(",") ]).each do |sa|
    #     rm = RelateMtv.new
    #     rm.altnet_id = art.id
    #     rm.similar_artist_id = sa.id       
    #     rm.position = h[sa.name]
    #     rm.score = rm.position 
    #     rm.save
    #     icount = icount + 1
    #   end # end of iteration
    # end #end of if

    if (ifound > 0)
      return 1
    else
      return 6
    end
  end #end of function


  def getSimilarArtistId artist
      
 
  end #end of function 

 def analyzeSimilarTrackRawDataImp track
    document = Hpricot(track.websource_track_similar_mtv.html.to_s)
    sarts = document.search("//span[@id='similar_song']")
    
    
    #RelateMtv.delete_all(:altnet_id => art.id)
    
    icount = 0
    ifound = 0
    sarts.each do |sart|
      #puts sart
      #puts sart
      regex = Regexp.new(/","(.*)",true.*<a.*>(.*?)<\/a>.*<a.*>(.*?)<\/a>/m)
      #regex2 = Regexp.new(/<a.*>(.*?)<\/a><br \/>.*<a/m)
      matchdata = regex.match(sart.to_s)
     #print matchdata
      icount = icount + 1
      
      if matchdata
        #similar_artist_name = matchdata[1]
        #puts matchdata[1]  + " - " + matchdata[2]+ " - " + matchdata[3]
        ifound = ifound + insertSimilarTrack(track.id, CGI.unescapeHTML(matchdata[2]), CGI.unescapeHTML(matchdata[3]), CGI.unescapeHTML(matchdata[1]), icount)
        #ifound = ifound + insertSimilarArtist(art.id, similar_artist_name, icount)
        #puts similar_artist_name           
      end
    end #end of iteration of artists 
    
    if (ifound > 0)
      return 1
    else
      return 6
    end
    
  end # end of function    
   
end
