class UseragentPool
  def initialize
  @Useragents = [
  "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10",
  "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/525.28.3 (KHTML, like Gecko) Version/3.2.3 Safari/525.28.3",
  "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.28.3 (KHTML, like Gecko) Version/3.2.3 Safari/525.28.3",
  "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.1 Safari/525.17",
  "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_2; en-us) AppleWebKit/525.13 (KHTML, like Gecko) Version/3.1 Safari/525.13",
  "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10",
  "Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.8) Gecko/20100723 Ubuntu/10.04 (lucid) Firefox/3.6.8",
  "Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.8) Gecko/20100723 Ubuntu/10.04 (lucid) Firefox/3.5.8",
  "Opera/9.80 (Windows NT 6.1; U; en) Presto/2.5.24 Version/10.54", 
  "Opera/9.80 (Windows NT 5.1; U; en) Presto/2.5.22 Version/10.50",
  "Opera/9.80 (Windows NT 6.0; U; en) Presto/2.5.22 Version/10.50",
  "Opera/9.80 (X11; Linux x86_64; U; Linux Mint; en) Presto/2.2.15 Version/10.10",
  "Opera/9.80 (Windows NT 5.2; U; en) Presto/2.2.15 Version/10.10",
  "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_1; en-us) AppleWebKit/533.17.6 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.6",
  "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.127 Safari/533.4",
  "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.125 Safari/533.4",
  "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.53 Safari/525.19",
  "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/532.5 (KHTML, like Gecko) Comodo_Dragon/4.0.1.6 Chrome/4.0.249.78 Safari/532.5",
  "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.9) Gecko/20100824 Firefox/3.6.9",
  "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100215 Solaris/10.1 (GNU) Superswan/3.5.8 (Byte/me)",
  "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10.5; en-US; rv:1.9.0.3) Gecko/2008092414 Firefox/3.0.3",
  "Mozilla/5.0 (X11; U; OpenBSD i386; en-US; rv:1.8.1.14) Gecko/20080821 Firefox/2.0.0.14",
  "Mozilla/5.0 (X11; U; Darwin Power Macintosh; en-US; rv:1.8.0.12) Gecko/20070803 Firefox/1.5.0.12 Fink Community Edition",
  "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB6.4; .NET CLR 1.1.4322; FDM; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)",
  "Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Rogers Hi·Speed Internet; (R1 1.3))"
  ]

  end


  def getRandomUseragent
    return @Useragents[rand(@Useragents.length)]
  end
  
end
