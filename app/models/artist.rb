class Artist < ActiveRecord::Base
    set_inheritance_column "ruby_type"

suppress(ActiveRecord::StatementInvalid) do
ActiveRecord::Base.connection.execute 'SET NAMES UTF8'
end

has_one :websource_lastfm, :foreign_key=>"altnet_id"
has_one :websource_artist_popular_lastfm, :foreign_key=>"altnet_id"
has_one :websource_yahoomusic, :foreign_key=>"altnet_id"
has_one :websource_mtv, :foreign_key=>"altnet_id"
has_one :websource_echonest, :foreign_key=>"altnet_id"
has_one :websource_artist_popular_echonest, :foreign_key=>"altnet_id"
has_one :p_stat, :foreign_key=>"altnet_id"
has_one :a_stat, :foreign_key=>"altnet_id"
has_one :popular_p_stat, :foreign_key=>"altnet_id"

has_many :albums, :conditions => {:is_valid => true}
has_many :tracks, :conditions => {:is_valid => true}
has_many :relate_lastfms, :foreign_key=>"altnet_id", :order => "position asc"
has_many :relate_musicbrainzs, :foreign_key=>"altnet_id", :order => "position asc"
has_many :relate_echonests, :foreign_key=>"altnet_id", :order => "position asc"
has_many :relate_yahoomusics, :foreign_key=>"altnet_id", :order => "position asc"
has_many :relate_mtvs, :foreign_key=>"altnet_id", :order => "position asc"


  # updated status after handled
  def updatePstatus(process_type, data_source_type, status)
    if (process_type == "similar artists")
      pStat = PStat.find_by_altnet_id(self.id)
    elsif (process_type == "artist popular")
      pStat = PopularPStat.find_by_altnet_id(self.id)
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
  def alreadyHandled(process_type,data_source_type,reDo)
    if (process_type == "similar artists")
      pStat = PStat.find_by_altnet_id(self.id)
    elsif (process_type == "artist popular")
      pStat = self.popular_p_stat
    end
    
    if (pStat == nil) 

      if (process_type == "similar artists")
        pStat =  PStat.new
      elsif (process_type == "artist popular")
        pStat = PopularPStat.new
      end
      
      pStat.altnet_id = self.id
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
