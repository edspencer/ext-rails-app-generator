class SelectedPlugin < ActiveRecord::Base
  belongs_to :site
  belongs_to :plugin
  
  validates_presence_of :site_id, :plugin_id
  
  def generator_call
    "ruby script/generate #{plugin.generator_name} #{generator_argument || plugin.default_generator_argument}"
  end
end
