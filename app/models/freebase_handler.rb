require 'rubygems'
require 'open-uri'
require 'pp'
require 'hpricot'
require 'uri'
require 'nokogiri'

class FreebaseHandler
  
  def solrAlbumSearch(album_name, artist_name)
    solrQueryStr = 'http://184.72.231.47:8983/solr/album/select?q=';
    solrQueryStr = solrQueryStr + album_name;
    solrQueryStr = solrQueryStr + '&bf=&qf=name_text^0.01&fq=artist_name_text:';
    solrQueryStr = solrQueryStr + artist_name;
    solrQueryStr = solrQueryStr + '&qt=radio&start=0&rows=1&wt=xml';
    return solrQueryStr
  end
  
  def self.matchDistance(str1, str2)
    a1 = str1.length;
    a2 = str2.length;
    if (a1 > a2)
      return a1 - a2;
    else
      return a2 - a1;
    end
  end
  
  def saveMatch(freebase_album,album_id, match_name)
    fMap = Freebasealbummap.new
    fMap.wpid = freebase_album.wpid;
    fMap.altnet_id = album_id;
    fMap.distance = FreebaseHandler.matchDistance(freebase_album.name, Album.find(album_id).name)
    fMap.freebase_name = freebase_album.name
    fMap.released = freebase_album.released
    fMap.genre = freebase_album.genre
    fMap.solr_match_name = match_name
    fMap.save();
  end
    
  def solrAlbumMatch(freebase_album, artist_name, match_name)
      url = solrAlbumSearch(match_name, artist_name);
      puts url;
      begin
        html = open(URI.encode(url));
        document = Hpricot(html)
        #ar = document.search("//div[@id='catalogueHead']");
        ar = document.search("//doc");
        
        ifound = 0
        ar.each do |sart|
          #puts sart
          regex = Regexp.new(/<str name="id">Album (.*)<\/str><arr name="name_text">/m)
          matchdata = regex.match(sart.to_s)
          
          
          
          if matchdata
            ifound = ifound + 1
            puts matchdata[1]
            saveMatch(freebase_album,matchdata[1], match_name)
          end
  
        end
    rescue Exception => e
      puts "html grab error"
      return ""
    end           
    

  end
  
  def albumMatch
    #1785 beyonce
    Artist.find(:all,:conditions =>["id = ?", 1785]).each do |artist|
      freebase_artist_name = Redirect.getFreebaseName(artist.name);
      if (freebase_artist_name != nil)
        freebase_albums = Freebasealbum.find(:all, :conditions =>["artist_name = ?", freebase_artist_name]);
        if (freebase_albums != nil)
          freebase_albums.each do |freebase_album|
            solrAlbumMatch(freebase_album, artist.name, freebase_album.name);
            aliases = Redirect.find(:all, :conditions =>["redirects_to = ?", freebase_album.name]);
            if (aliases != nil)
              aliases.each do |aliase|
                if (aliase.name.downcase != freebase_album.name)
                  solrAlbumMatch(freebase_album, artist.name, aliase.name);
                end # end of id
              end # end of artist loop
            end # end of if
          end # end of freebase album loop
        end # end of album empty
      end # end of freebase artist name empty
    end # end of artist loop
  end # end of function
end
