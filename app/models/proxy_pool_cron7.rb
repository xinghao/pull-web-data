class ProxyPoolCron7 < ProxyPool 
  
  def initialize
    network4 = (4..75).to_a
    @proxyHash = {"64.150.187" => network4}
        
  end
  
end
