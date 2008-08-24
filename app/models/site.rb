class Site < ActiveRecord::Base
  validates_presence_of :user_id, :name
  
  belongs_to :user
  has_many :models
  has_many :selected_plugins
  has_many :plugins, :through => :selected_plugins
  
  def scm_object
    @scm_object ||= Scm.new_scm(self.scm, self)
  end
  
  def generation_time
    (generation_stop_time - generation_start_time).to_i
  end
  
  def self.average_generation_time
    res = ActiveRecord::Base.connection.execute("SELECT sum(abs(generation_stop_time - generation_start_time)) as total_time, count(*) as count from sites")
    
    res['total_time'].to_i / res['count'].to_i
  end
  
  def underscored_name
    name.gsub(" ", "_").gsub(/[^A-Za-z0-9\-\_]/, '')
  end
  
  # kicks off the generation process
  def generate!
    generate_rails!
    remove_unwanted_files!
    scm_object.initialize_repository
    scm_object.install_plugins
    
    scm_object.track_all_files
    scm_object.push_to_server
  end
  
  # protected
  
  # Runs the appropriate rails generate script
  def generate_rails!
    #make sure we're on the bleeding edge before generating
    system("cd vendor/rails_versions/edge && git pull") if self.rails_version == 'edge'
    system("cd ../ && ruby #{Dir.pwd}/#{rails_generate_path} #{self.underscored_name}")
  end
  
  # Removes files such as index.html, database.yml etc
  def remove_unwanted_files!
    system("cd ../#{self.underscored_name} && rm public/index.html public/images/rails.png")
    system("cd ../#{self.underscored_name} && mv config/database.yml config/database.yml.example")
  end
  
  def rails_generate_path
    "vendor/rails_versions/#{self.rails_version}/railties/bin/rails"
  end
  
end
