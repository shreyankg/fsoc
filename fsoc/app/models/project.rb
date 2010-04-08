class Project < ActiveRecord::Base
  validates_presence_of     :name, :definition, :eta
  validates_numericality_of :eta, :greater_than => 0
end
