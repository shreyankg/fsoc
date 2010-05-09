class TaskEndDate < ActiveRecord::Migration
  def self.up
    add_column :tasks, :end_date, :date
  end

  def self.down
    remove_column :tasks, :end_date  
  end
end
