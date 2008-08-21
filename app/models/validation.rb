class Validation < ActiveRecord::Base
  VALIDATION_TYPES = %w(validates_presence_of validates_acceptance_of validates_confirmation_of validates_uniqueness_of validates_numericality_of)
  belongs_to :column
  
  validates_presence_of :column_id
  validates_inclusion_of :validation_type, :in => VALIDATION_TYPES
end
