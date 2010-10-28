class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks, :conditions => {:is_valid => true}, :dependent => :destroy, :order => 'track_number ASC'
  has_one :websource_album_popular_lastfm, :foreign_key=>"altnet_id"
end
