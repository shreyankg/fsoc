class ProjectUpdate < ActiveRecord::Migration
  def self.up
    change_table :projects do |t| 
      t.string :status, :default => "proposed"
      t.integer :proposed_by
      t.integer :mentor
      t.integer :student
      t.string :urls
      
    end   
  end

  def self.down
    remove_column :projects, :status, :proposed_by, :mentor, :student, :urls
  end
end
