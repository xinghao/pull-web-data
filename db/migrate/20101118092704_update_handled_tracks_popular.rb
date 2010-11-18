class UpdateHandledTracksPopular < ActiveRecord::Migration
  def self.up
    create_table :popular_tracks_lastfm_temps_1 do |t|
      t.integer :altnet_id
    end    
    add_index :popular_tracks_lastfm_temps_1, [:altnet_id]
  end

  def self.down
  end
end
