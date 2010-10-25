class ProxyPool
  
  def initialize
    #cron3
    network7 = (128..143).to_a
    @proxyHash = {"208.43.250" => network7}
    network8 = (225..238).to_a
    @proxyHash["174.37.219"] = network8
    network9 = (128..191).to_a
    @proxyHash["174.37.236"] = network9
    
    #cron4
    network10 = (171..174).to_a
    @proxyHash["69.72.194"] = network10
    network11 = (33..46).to_a
    @proxyHash["69.72.150"] = network11
    network12 = (17..30).to_a
    @proxyHash["69.72.152"] = network12
    
    #cron 2
    network1 = (128..143).to_a
    @proxyHash = {"174.37.114" => network1}
    network2 = (64..127).to_a
    @proxyHash["173.192.8"] = network2
    network3 = (33..46).to_a
    @proxyHash["67.228.156"] = network3
    network4 = (46..63).to_a
    @proxyHash["67.228.237"] = network4
    network5 = (49..62).to_a
    @proxyHash["67.228.223"] = network5
    network6 = (128..191).to_a
    @proxyHash["67.228.88"] = network6
        
  end

  def testProxy
    networks = @proxyHash.keys
        
    url = "http://www.yahoo.com/"
    networks.each do |network|
      proxy_id = network + "." + @proxyHash[network][rand(@proxyHash[network].length)].to_s()
      #document = Hpricot(open(url, :proxy=>"http://" + proxy_id + ":3128/"))
      #ar = document.search("//div[@id='y-masthead']");
      ar = ""
      print proxy_id + ": "
      if (ar.empty?)
        puts "failed!"
      else
        puts "working"
      end
    end
  end
    
  def getRandomProxy
    networks = @proxyHash.keys

    #puts proxyHash.keys.length
    key = rand(networks.length)
    proxy_id = networks[key] + "." + @proxyHash[networks[key]][rand(@proxyHash[networks[key]].length)].to_s()
    return "http://" + proxy_id + ":3128/"
  end
  
end
