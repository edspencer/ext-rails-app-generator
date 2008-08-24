class Log < ActiveRecord::Base
  belongs_to :site
  validates_presence_of :site_id, :message
end
