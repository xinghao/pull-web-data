class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist
  has_one :websource_track_similar_lastfm, :foreign_key=>"altnet_id"
  has_one :websource_track_similar_mtv, :foreign_key=>"altnet_id"
  has_one :aggregate_similar_tracks_stat, :foreign_key=>"altnet_id"
end
