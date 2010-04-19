class Project < ActiveRecord::Base
  validates_presence_of     :name, :definition, :eta
  validates_numericality_of :eta, :greater_than => 0
  belongs_to :proposer, :class_name => "User", :foreign_key => "proposed_by"
  belongs_to :mentor_user, :class_name => "User", :foreign_key => "mentor"
  belongs_to :student_user, :class_name => "User", :foreign_key => "student"
end
