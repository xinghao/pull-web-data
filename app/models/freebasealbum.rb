require 'composite_primary_keys'
#http://compositekeys.rubyforge.org/

class Freebasealbum < ActiveRecord::Base
  set_inheritance_column "ruby_type"
  establish_connection :postgres_development
  set_primary_keys :wpid
  
  
  def getArtistName
      if (xml == nil) 
        return "";
      end
      doc = Hpricot.XML(xml);
      ar = doc.search("//param[@name='Artist']").search("//target");
      
      ifound = 0
      ar.each do |sart|
        #puts sart
        regex = Regexp.new(/<target>(.*)<\/target>/)
        matchdata = regex.match(sart.to_s)
        
        
        
        if matchdata
          ifound = ifound + 1
          #puts matchdata[1]
          return matchdata[1]
        end
        return ""
      end  
      return ""      

  end
  
  def getReleaseDate
      if (xml == nil) 
        return "";
      end
      doc = Hpricot.XML(xml);
      ar = doc.search("//param[@name='Released']")
      
      ifound = 0
      ar.each do |sart|
        #puts sart
        regex = Regexp.new(/>(.*)<\/param>/)
        matchdata = regex.match(sart.to_s)
        
        
        
        if matchdata
          ifound = ifound + 1
          #puts matchdata[1]
          return matchdata[1]
        end
        return ""
      end  
      return ""      

  end

  def getGenre
      if (xml == nil) 
        return "";
      end
      doc = Hpricot.XML(xml);
      ar = doc.search("//param[@name='Genre']").search("//target");
      
      ifound = 0
      ar.each do |sart|
        #puts sart
        regex = Regexp.new(/<target>(.*)<\/target>/)
        matchdata = regex.match(sart.to_s)
        
        
        
        if matchdata
          ifound = ifound + 1
          #puts matchdata[1]
          return matchdata[1]
        end
        return ""
      end  
      return ""      

  end
  
      
end
