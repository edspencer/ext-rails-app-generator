class Model < ActiveRecord::Base
  validates_presence_of :site_id, :name
  belongs_to :site
end
