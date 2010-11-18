class CreatePopularTracksLastfm050100Temps < ActiveRecord::Migration
  def self.up
    create_table :popular_tracks_lastfm050100_temps do |t|
      t.integer :altnet_id
      t.decimal :lastfm, :precision => 65, :scale => 30
      t.integer :version, :default => 1
      t.timestamps
    end
    
    add_index :popular_tracks_lastfm050100_temps, [:altnet_id]
  end

  def self.down
    drop_table :popular_tracks_lastfm050100_temps
  end
end
