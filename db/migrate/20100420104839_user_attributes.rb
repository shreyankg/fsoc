class UserAttributes < ActiveRecord::Migration
  def self.up
    change_table :users do |t| 
      t.string :webpage
      t.string :irc_nick
      t.string :irc_channels
      t.string :org
      t.text :bio
    end   
  end

  def self.down
    remove_column :users, :webpage, :irc_nick, :irc_channels, :org,  :bio
  end
end
