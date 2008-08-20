class SelectedPlugin < ActiveRecord::Base
  belongs_to :site
  belongs_to :plugin
  
  validates_presence_of :site_id, :plugin_id
end
