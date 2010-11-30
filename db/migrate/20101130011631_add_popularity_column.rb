class AddPopularityColumn < ActiveRecord::Migration
  def self.up
    add_column :artists, :aggregated_popularity, :decimal, :default => 0, :precision => 10, :scale => 8
    add_column :albums, :aggregated_popularity, :decimal, :default => 0, :precision => 10, :scale => 8
    add_column :tracks, :aggregated_popularity, :decimal, :default => 0, :precision => 10, :scale => 8    
  end

  def self.down
  end
end
