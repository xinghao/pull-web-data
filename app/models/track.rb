class Track < ActiveRecord::Base
  belongs_to :album
  has_one :websource_track_similar_lastfm, :foreign_key=>"altnet_id"
  has_one :websource_track_similar_mtv, :foreign_key=>"altnet_id"
end
