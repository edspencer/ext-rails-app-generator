class Plugin < ActiveRecord::Base
  validates_presence_of :remote_url, :local_path, :name
  validates_uniqueness_of :remote_url, :local_path, :name
end
