class SignoffStatus < ActiveRecord::Migration
  def self.up
    add_column :tasks, :signoff_date, :date
    add_column :tasks, :status, :string
    add_column :projects, :signoff_date, :date

  end

  def self.down
    remove_column :tasks, :signoff_date, :status
    remove_column :projects, :signoff_date
  end
end
