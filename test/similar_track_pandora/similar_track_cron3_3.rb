# cron2:  0 - 300,000
# cron3:  300,000 - 600,000
# cron4:  600,000 - 900,000
# cron5:  900,000 - 1,200,000
# cron6:  1,200,000 - 1,6000,000

#ProxyPool.setCurrentCronServer "cron3"
lm = MtvDataSourceHandler.new
#lm.getWebRawSimilarTrackData(300000,100000)
#lm.getWebRawSimilarTrackData(400000,100000)
lm.getWebRawSimilarTrackData(500000,100000)
