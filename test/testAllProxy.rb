# lm = LastfmDataSourceHandler.new;
# lm.analyzeArtistPopularRowData
# e = EchonestDataSourceHandler.new
# e.analyzeArtistPopularRowData
#art = Artist.find(1);
#lm.analyzePopularArtistRawData art


# regex = Regexp.new(/\((.*) listeners\)/)
# matchdata = regex.match("(2,216,732 listeners)")
# puts matchdata[1]

ProxyPool.setCurrentCronServer "cron2"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy


ProxyPool.setCurrentCronServer "cron3"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy

ProxyPool.setCurrentCronServer "cron4"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy

ProxyPool.setCurrentCronServer "cron5"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy

ProxyPool.setCurrentCronServer "cron6"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy

ProxyPool.setCurrentCronServer "cron7"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy

ProxyPool.setCurrentCronServer "cron9"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy

ProxyPool.setCurrentCronServer "cron10"
cron = ProxyPool.cronServerProvider
cron.testCurrentCronAllProxy


