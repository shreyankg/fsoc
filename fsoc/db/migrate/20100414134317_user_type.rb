class UserType < ActiveRecord::Migration
  def self.up
    change_table :users do |t| 
      t.string :user_type, :default => "student"
    end 
  end

  def self.down
    remove_column :users, :user_type
  end
end
