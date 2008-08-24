class Plugin < ActiveRecord::Base
  validates_presence_of :remote_url, :local_path, :name
  validates_uniqueness_of :remote_url, :local_path, :name
  
  def generator_call_required?
    !generator_name.blank?
  end
end
