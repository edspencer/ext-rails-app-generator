class Association < ActiveRecord::Base
  ASSOCIATION_TYPES = %w(has_many has_one belongs_to has_and_belongs_to_many)
  
  belongs_to :model
  belongs_to :foreign_model, :class_name => 'Model'
  
  validates_presence_of :association_type
  validates_inclusion_of :association_type, :in => ASSOCIATION_TYPES
end
