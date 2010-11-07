# cron2:  0 - 300,000
# cron3:  300,000 - 600,000
# cron4:  600,000 - 900,000
# cron5:  900,000 - 1,200,000
# cron6:  1,200,000 - 1,6000,000

lm = LastfmDataSourceHandler.new
lm.getWebRawSimilarTrackData(900000,100000)
#lm.getWebRawSimilarTrackData(1300000,100000)
#lm.getWebRawSimilarTrackData(1400000,100000)
#lm.getWebRawSimilarTrackData(1500000,100000)
