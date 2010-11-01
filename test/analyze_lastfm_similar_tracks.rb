# lm = LastfmDataSourceHandler.new;
# lm.analyzeArtistPopularRowData
# e = EchonestDataSourceHandler.new
# e.analyzeArtistPopularRowData
#art = Artist.find(1);
#lm.analyzePopularArtistRawData art


# regex = Regexp.new(/\((.*) listeners\)/)
# matchdata = regex.match("(2,216,732 listeners)")
# puts matchdata[1]


#r = RawWebData.new
#r.getLastFmSimilarTrackData("the rolling stones", "album_name", "come on")
#r.getPandoraSimilarTrackData("beyonce", "", "halo")

#tar = Track.find(:first)
#lm = LastfmDataSourceHandler.new
#lm.getSimilarTrackWebRawDataImp tar

#track = Track.find(1)
 lm = LastfmDataSourceHandler.new
# lm.getWebRawSimilarTrackData(0,3)
 lm.analyzeSimilarTrackRawData(0,5000)
# mtv = MtvDataSourceHandler.new;
# mtv.getWebRawSimilarTrackData(0,20)
#track = Track.find(2)
#mtv.analyzeSimilarTrackRawDataImp(track)
#album = Album.find(1)
#lm.analyzePopularAlbumRawData album
#lm.analyzeAlbumPopularRowData
#ProxyPool.setCurrentCronServer "cron10"
#pPool = ProxyPool.cronServerProvider

# a = Aggregator.new;
# a.aggredateSimilarTracks(0,1)
