class SimilarTrackScore < SimilarArtistScore
    def initialize
      @score = 0
      @appearance = 0
      @lastfm = 0.1
      @mtv = 0.09
            
      @mz = 0.001
      @echonest = 0.00001
      @yahoomusic = 0.0000001

    end

  

end
