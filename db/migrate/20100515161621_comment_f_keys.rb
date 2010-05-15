class CommentFKeys < ActiveRecord::Migration
  def self.up
    add_column :comments, :author_id, :integer
  end

  def self.down
    remove_column :comments, :author_id
  end
end
