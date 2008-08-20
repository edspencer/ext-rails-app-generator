class Column < ActiveRecord::Base
  belongs_to :model
  
  validates_presence_of :model_id, :name, :column_type
end
