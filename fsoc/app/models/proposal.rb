class Proposal < ActiveRecord::Base
  validates_presence_of :proposal_text
  
  belongs_to :project
  belongs_to :student, :class_name => "User", :foreign_key => "student_id"
end
