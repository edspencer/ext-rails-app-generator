class Controller < ActiveRecord::Base
  acts_as_nested_set
  
  belongs_to :model #optional, some controllers may not map to a model
  
  validates_presence_of :name
end
