class CreateWebsourceAlbumPopularLastfms < ActiveRecord::Migration
  def self.up
    create_table :websource_album_popular_lastfms do |t|
      t.integer :altnet_id
      t.text :html
      t.text :url

      t.timestamps
    end
  end

  def self.down
    drop_table :websource_album_popular_lastfms
  end
end
