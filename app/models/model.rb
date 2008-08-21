class Model < ActiveRecord::Base
  has_many :columns
  has_many :validations
  has_many :associations
  belongs_to :site
  
  validates_presence_of :site_id, :name

end
