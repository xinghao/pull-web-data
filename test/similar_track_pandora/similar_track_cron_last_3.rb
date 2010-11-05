# cron2:  0 - 300,000
# cron3:  300,000 - 600,000
# cron4:  600,000 - 900,000
# cron5:  900,000 - 1,200,000
# cron6:  1,200,000 - 1,6000,000

#ProxyPool.setCurrentCronServer "cron2"
lm = MtvDataSourceHandler.new
lm.getWebRawSimilarTrackData(800000,400000)
#lm.getWebRawSimilarTrackData(100000,100000)
#lm.getWebRawSimilarTrackData(200000,100000)
