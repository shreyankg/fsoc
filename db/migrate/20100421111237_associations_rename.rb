class AssociationsRename < ActiveRecord::Migration
  def self.up
    rename_column :projects, :proposed_by, :proposer_id
    rename_column :projects, :mentor, :mentor_id
    rename_column :projects, :student, :student_id
  end

  def self.down
    rename_column :projects, :proposer_id, :proposed_by
    rename_column :projects, :mentor_id, :mentor
    rename_column :projects, :student_id  , :student
  end
end
