class Column < ActiveRecord::Base
  belongs_to :model
  has_many :validations
  
  validates_presence_of :model_id, :name, :column_type
end
