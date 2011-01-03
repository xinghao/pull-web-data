class CreateVersonControls < ActiveRecord::Migration
  def self.up
    create_table :verson_controls do |t|
      t.string :task_type
      t.integer :version

      t.timestamps
    end
    
    execute "insert into verson_controls(task_type, version) values('similar artists', 0)"
    execute "insert into verson_controls(task_type, version) values('similar tracks', 0)"
    execute "insert into verson_controls(task_type, version) values('popular artists', 0)"
    execute "insert into verson_controls(task_type, version) values('popular artists', 0)"
    execute "insert into verson_controls(task_type, version) values('popular artists', 0)"
    
  end

  def self.down
    drop_table :verson_controls
  end
end
