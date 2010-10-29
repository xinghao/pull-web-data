class ProxyPoolCron5 < ProxyPool 
  
  def initialize
    network11 = (122..126).to_a
    network12 = (130..134).to_a
    network13 = (170..174).to_a
    network1 = network11 + network12 + network13 
    @proxyHash = {"65.60.62"  => network1}
    
    network2 = (58..62).to_a
    @proxyHash["65.60.34"] = network2
    
    network3 = (226..230).to_a
    @proxyHash["67.212.170"] = network3
    
    network4 = (98..102).to_a
    @proxyHash["216.104.42"] = network4
   
    network5 = (138..142).to_a    
    @proxyHash["67.212.178"] = network5

    network6 = (218..222).to_a    
    @proxyHash["67.212.189"] = network6

    network7 = (42..46).to_a    
    @proxyHash["67.212.186"] = network7
    
    #cron 2        
  end
  
end
