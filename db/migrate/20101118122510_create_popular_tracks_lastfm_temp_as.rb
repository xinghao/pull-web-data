class CreatePopularTracksLastfmTempAs < ActiveRecord::Migration
  def self.up
    create_table :popular_tracks_lastfm_temp_as do |t|
      t.integer :altnet_id
      t.decimal :lastfm, :precision => 65, :scale => 30
      t.integer :version, :default => 1
    end
    add_index :popular_tracks_lastfm_temp_as, [:altnet_id]
  end

  def self.down
    drop_table :popular_tracks_lastfm_temp_as
  end
end
