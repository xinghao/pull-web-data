class CreateWebsourceTrackSimilarLastfmV1s < ActiveRecord::Migration
  def self.up
    create_table :websource_track_similar_lastfm_v1s do |t|
      t.integer :altnet_id
      t.text :html
      t.text :url

      t.timestamps
    end
    add_index :websource_track_similar_lastfm_v1s, [:altnet_id]
  end

  def self.down
    remove_index :websource_track_similar_lastfm_v1s, [:altnet_id]
    drop_table :websource_track_similar_lastfm_v1s
  end
  
end
