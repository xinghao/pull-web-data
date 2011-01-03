class CreateFreebasealbummaps < ActiveRecord::Migration
  def self.up
    create_table :freebasealbummaps do |t|
      t.integer :altnet_id
      t.integer :wpid
      t.integer :distance
      t.text    :freebase_name
      t.text    :released
      t.text    :genre
      t.text    :solr_match_name

      t.timestamps
    end
  end

  def self.down
    drop_table :freebasealbummaps
  end
end
