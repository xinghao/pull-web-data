class ProxyPoolCron3 < ProxyPool 
  
  def initialize
    #cron10
    network7 = (128..143).to_a
    @proxyHash = {"208.43.250" => network7}
    network8 = (225..238).to_a
    @proxyHash["174.37.219"] = network8
    network9 = (128..191).to_a
    @proxyHash["174.37.236"] = network9
        
  end
  
end
