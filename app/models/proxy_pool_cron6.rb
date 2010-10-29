class ProxyPoolCron6 < ProxyPool 
  
  def initialize
    network10 = (2..126).to_a
    @proxyHash = {"68.233.227"  => network10}
    
    #cron 2        
  end
  
end
