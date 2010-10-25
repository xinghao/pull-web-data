class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks, :conditions => {:is_valid => true}, :dependent => :destroy, :order => 'track_number ASC'
end
