class ProxyPoolCron9 < ProxyPool 
  
  def initialize
    #cron10
    network11 = (130..142).to_a
    network12 = (146..158).to_a
    network13 = (162..174).to_a
    network14 = (178..190).to_a
    network = network11 + network12 + network13 + network14 
    @proxyHash = {"174.34.139" => network1}
    network21 = (194..208).to_a
    network22 = (162..174).to_a
    network23 = (178..190).to_a
    network2 = network21 + network22 + network23
    @proxyHash["64.120.46"] = network2
        
  end
  
end
