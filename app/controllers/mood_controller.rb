class MoodController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @tracks = Track.moodSearch(params[:search]);
  end
  
  def radio
      @popular_track = PopularTrack.find_by_altnet_id(params[:id]);
      @rawTrack = Track.find(params[:id]);
      @rawArtist = Artist.find(@rawTrack.artist_id)

    @tracks = Track.moodRadio(@popular_track)
  end

end
