class TaskFields < ActiveRecord::Migration
  def self.up
    add_column :tasks, :start_date, :date
    add_column :tasks, :title, :string
    add_column :tasks, :eta, :integer 
    rename_column :tasks, :task_text, :description
  end

  def self.down
    remove_column :tasks, :start_date, :title, :eta
    rename_column :tasks, :description, :task_text    
  end
end
