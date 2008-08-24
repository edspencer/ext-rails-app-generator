class Site < ActiveRecord::Base
  validates_presence_of :user_id, :name
  
  belongs_to :user
  has_many :models
  has_many :selected_plugins
  has_many :plugins, :through => :selected_plugins
  
  def generation_time
    (generation_stop_time - generation_start_time).to_i
  end
  
  def self.average_generation_time
    res = ActiveRecord::Base.connection.execute("SELECT sum(abs(generation_stop_time - generation_start_time)) as total_time, count(*) as count from sites")
    
    res['total_time'].to_i / res['count'].to_i
  end
end
