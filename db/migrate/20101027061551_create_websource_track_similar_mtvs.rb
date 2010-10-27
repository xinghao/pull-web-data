class CreateWebsourceTrackSimilarMtvs < ActiveRecord::Migration
  def self.up
    create_table :websource_track_similar_mtvs do |t|
      t.integer :altnet_id
      t.text :html
      t.text :url

      t.timestamps
    end
    add_index :websource_track_similar_mtvs, [:altnet_id]
  end

  def self.down
    remove_index :websource_track_similar_mtvs, [:altnet_id]
    drop_table :websource_track_similar_mtvs
  end
end
