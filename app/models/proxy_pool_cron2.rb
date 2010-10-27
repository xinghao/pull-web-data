class ProxyPoolCron2 < ProxyPool 
  
  def initialize
    network4 = (48..63).to_a
    @proxyHash = {"67.228.237" => network4}
    network5 = (49..62).to_a
    @proxyHash["67.228.223"] = network5
    network6 = (128..191).to_a
    @proxyHash["67.228.88"] = network6
        
  end
  
end
