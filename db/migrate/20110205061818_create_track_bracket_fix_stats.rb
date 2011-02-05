class CreateTrackBracketFixStats < ActiveRecord::Migration
  def self.up
    # create_table :track_bracket_fix_stats do |t|
    #   t.integer :track_id
    #   t.string :track_name
    #   t.string :track_name_no_brackets
    #   t.integer :status
    # 
    #   t.timestamps
    # end
  end

  def self.down
    drop_table :track_bracket_fix_stats
  end
end
