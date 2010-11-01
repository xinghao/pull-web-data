class CreateAggregateSimilarTracksStats < ActiveRecord::Migration
  def self.up
    create_table :aggregate_similar_tracks_stats do |t|
      t.integer :altnet_id
      t.integer :status

      t.timestamps
    end
    add_index :aggregate_similar_tracks_stats, [:altnet_id]
  end

  def self.down
    remove_index :aggregate_similar_tracks_stats, [:altnet_id]
    drop_table :aggregate_similar_tracks_stats
  end
end
