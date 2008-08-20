class Site < ActiveRecord::Base
  validates_presence_of :user_id, :name
  
  belongs_to :user
  has_many :models
  has_many :selected_plugins
  has_many :plugins, :through => :selected_plugins
end
