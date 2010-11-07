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
#r.getLastFmSimilarTrackData("Johnny Hallyday", "album_name", "J'Oublierai Ton Nom")
#r.getPandoraSimilarTrackData("beyonce", "", "halo")
#r.getLastfmTrackPopularity("beyonce", "", "halo")
#r.getEchonestTrackPopularity("beyonce", "", "halo")
tar = Track.find(19430)
lm = LastfmDataSourceHandler.new
lm.getSimilarTrackWebRawDataImp tar
#lm.getPopularTrackWebRawDataImp tar
#e = EchonestDataSourceHandler.new
#artist = Artist.find(9391)
#e.getPopularArtistWebRawDataImp artist
#e.getPopularTrackWebRawDataImp tar
#e.getWebRawTrackPopularData(0,10)
#lm.getWebRawTrackPopularData(0,10)
#track = Track.find(504257)
#lm = LastfmDataSourceHandler.new
#lm.analyzeSimilarTrackRawDataImp(track)
# lm.getWebRawSimilarTrackData(0,3)
# lm.analyzeSimilarTrackRawData(0,3)
# mtv = MtvDataSourceHandler.new;
# mtv.getWebRawSimilarTrackData(0,20)
#track = Track.find(2)
#mtv.analyzeSimilarTrackRawDataImp(track)
#album = Album.find(1)
#lm.analyzePopularAlbumRawData album
#lm.analyzeAlbumPopularRowData
#ProxyPool.setCurrentCronServer "cron10"
#pPool = ProxyPool.cronServerProvider

#  a = Aggregator.new;
 # a.aggredateSimilarTracks(0,1)
# a.aggregateSimilarTracks(0,5000)

#e = EchonestDataSourceHandler.new
#e.getWebRawArtistPopularData