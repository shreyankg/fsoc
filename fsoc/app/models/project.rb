class Project < ActiveRecord::Base
  validates_presence_of     :name, :definition, :eta
  validates_numericality_of :eta, :greater_than => 0
  
  belongs_to :proposer, :class_name => "User", :foreign_key => "proposer_id"
  belongs_to :mentor, :class_name => "User", :foreign_key => "mentor_id"
  belongs_to :student, :class_name => "User", :foreign_key => "student_id"
end
