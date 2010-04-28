class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.references :project
      t.references :student
      t.text :proposal_text
      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
