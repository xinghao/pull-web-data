class ProxyPoolCron4 < ProxyPool 
  
  def initialize
    network10 = (171..174).to_a
    @proxyHash = {"69.72.194"  => network10}
    network21 = (33..46).to_a
    network22 = (49..62).to_a
    network23 = (193..206).to_a
    network24 = (209..222).to_a
    network2 = network21 + network22 + network23 + network24
    @proxyHash["69.72.150"] = network2
    network31 = (17..30).to_a
    network32 = (33..46).to_a
    network33 = (49..62).to_a
    network3 = network31 + network32 + network33
    @proxyHash["69.72.152"] = network3
    
    #cron 2        
  end
  
end
