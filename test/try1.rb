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

tar = Track.find(:first)
lm = LastfmDataSourceHandler.new
lm.getSimilarTrackWebRawDataImp tar

