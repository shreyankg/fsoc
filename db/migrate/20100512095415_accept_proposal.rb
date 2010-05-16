class AcceptProposal < ActiveRecord::Migration
  def self.up
    add_column :proposals, :accepted, :boolean, :default => false
    add_column :tasks, :proposal_id, :integer
    remove_column :tasks, :student_id
    remove_column :projects, :student_id
  end

  def self.down
    remove_column :proposals, :accepted
    remove_column :tasks, :proposal_id 
    add_column :tasks, :student_id, :integer
    add_column :projects, :student_id, :integer
  end
end
