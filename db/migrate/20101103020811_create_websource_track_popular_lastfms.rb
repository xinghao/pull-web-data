class CreateWebsourceTrackPopularLastfms < ActiveRecord::Migration
  def self.up
    create_table :websource_track_popular_lastfms do |t|
      t.integer :altnet_id
      t.text :html
      t.text :url

      t.timestamps
    end
    add_index :websource_track_popular_lastfms, [:altnet_id]
  end

  def self.down
    remove_index :websource_track_popular_lastfms, [:altnet_id]
    drop_table :websource_track_popular_lastfms
  end
end
