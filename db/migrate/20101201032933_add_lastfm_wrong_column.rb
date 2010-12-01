class AddLastfmWrongColumn < ActiveRecord::Migration
  def self.up
    add_column :popular_p_stats, :lastfm_wrong, :integer, :default=>0
  end

  def self.down
  end
end
