class AddSimilarTracksCountToVersionControl < ActiveRecord::Migration
  def self.up
      add_column :charts_raw_contents, :similar_track_count, :integer
  end

  def self.down
  end
end
