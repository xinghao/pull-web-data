require 'hpricot'
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
#r.getLastfmArtistPopularity("Rufus Featuring Chaka Khan");
#r.getLastFmSimilarTrackData("Johnny Hallyday", "album_name", "J'Oublierai Ton Nom")
#r.getPandoraSimilarTrackData("beyonce", "", "halo")
#r.getLastfmTrackPopularity("beyonce", "", "halo")
#r.getEchonestTrackPopularity("beyonce", "", "halo")
#track = Track.find(1)
#lm = LastfmDataSourceHandler.new
#lm.checkArtistPopularWrongData
#art = Artist.find_by_name("Rufus Featuring Chaka Khan");
#art = Artist.find_by_name("the rolling stones");
#art = Artist.find_by_name("beyonce");
#art=Artist.find(30016);
#lm.analyzePopularArtistWrongData art
#lm.analyzeTrackPopularRowData
#lm.getTrackPopularityFromSimilarTracksData
#lm.analyzePopularTrackRawDataImpl track
#lm.analyzePopularityFromSimilarTracksDataImp(track)
#lm.getSimilarTrackWebRawDataImp track
#lm.getPopularTrackWebRawDataImp track
#e = EchonestDataSourceHandler.new
#artist = Artist.find(9391)
#e.getPopularArtistWebRawDataImp artist
#e.getPopularTrackWebRawDataImp tar
#e.getWebRawTrackPopularData(0,10)
#e.analyzePopularTrackRawDataImpl track
#e.analyzeTrackPopularRowData
#lm.getWebRawTrackPopularData(0,10)
# track = Track.find(1030203)
# lm = LastfmDataSourceHandler.new
# lm.analyzeSimilarTrackRawDataImp(track)
# lm.getWebRawSimilarTrackData(0,3)
# lm.analyzeSimilarTrackRawData(0,3)
#track = Track.find(2)
# mtv = MtvDataSourceHandler.new;
# mtv.getSimilarTrackWebRawDataImp track
# mtv.getWebRawSimilarTrackData(0,20)

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

## freebase --start
# Freebasealbum.find(:all).each do |album|
#   puts "handling: "+album.wpid.to_s
#   album.artist_name = album.getArtistName()
#   album.released = album.getReleaseDate()
#   album.genre = album.getGenre()   
#   puts  album.artist_name
#   puts album.released
#   puts album.genre
#   album.save()   
#   
# end
# puts "Done..."   
#puts Redirect.getFreebaseName('Beyoncé');
# f = FreebaseHandler.new
# f.albumMatch()
# sc = SimilarTracksVersionControl.new;
# #sc.getSimilarTracks();
# sc.aggregateSimilarTracks();

fix = TrackNameFix.new();
#fix.batchScanTrackNameBracketsFix();
#fix.batchTrackNameBracketsFixByMatchOtherTrackName();
fix.batchTrackNameBracketsFixByScrapingGeting();
#fix.batchTrackNameBracketsFixByScrapingAnalyzing();
#fix.batchTrackNameBracketsFixByScrapingAggregating();
