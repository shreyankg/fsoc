class DueDate < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :end_date, :due_date
  end

  def self.down
    rename_column :tasks, :due_date, :end_date
  end
end
