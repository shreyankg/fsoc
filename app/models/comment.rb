class Comment < ActiveRecord::Base
	validates_presence_of :content
	belongs_to :author, :class_name => "User", :foreign_key => "author_id"
	belongs_to :project
end
