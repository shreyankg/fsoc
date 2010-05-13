class AcceptedStatus < ActiveRecord::Migration
  def self.up
    remove_column :proposals, :accepted
    add_column :proposals, :status, :string, :default => 'pending'
  end

  def self.down
    add_column :proposals, :accepted, :boolean
    remove_column :proposals, :status
  end
end
