class ProxyPoolCron10 < ProxyPool 
  
  def initialize
    #cron10
    network7 = (140..153).to_a
    @proxyHash = {"216.240.131" => network7}
    network8 = (222..237).to_a
    @proxyHash["216.240.134"] = network8
    network9 = (187..202).to_a
    @proxyHash["216.240.148"] = network9    
    network10 = (96..127).to_a
    @proxyHash["216.240.157"] = network10
        
  end
  
end
