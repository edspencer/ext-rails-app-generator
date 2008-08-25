require 'acts_as_state_machine'

class Site < ActiveRecord::Base
  validates_presence_of :user_id, :name
  
  belongs_to :user
  has_many :models
  has_many :controllers, :through => :models
  has_many :selected_plugins
  has_many :plugins, :through => :selected_plugins
  has_many :logs
  
  acts_as_state_machine :initial => :new
  
  state :new
  state :pending_generation, :enter => Proc.new {|site| site.do_generate_in_background}
  state :generating
  state :generated
  
  event :generate do
    transitions :from => [:new, :generated], :to => :pending_generation
  end
  
  event :generation_started do
    transitions :from => :pending_generation, :to => :generating
  end
  
  event :generation_completed do
    transitions :from => :generating, :to => :generated
  end
  
  def scm_object
    @scm_object ||= Git.new(self) #Scm.new_scm(self.scm, self)
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
  
  def do_generate_in_background
    work = WorkerQueue::WorkerQueueItem.new
    work.class_name    = 'Site'
    work.method_name   = 'do_generate'
    work.argument_hash = {:id => self.id}
    work.save!
  end
  
  def self.do_generate(args = {})
    find(args[:id]).do_generate
  end
  
  # kicks off the generation process
  def do_generate(in_background = true)
    update_attributes(:generation_start_time => Time.now)
    logs.create(:message => 'Started generate process')
    generation_started!
    
    generate_rails!
    logs.create(:message => 'Generated Rails')
    
    remove_unwanted_files!
    logs.create(:message => 'Removed unwanted files')
    
    scm_object.initialize_repository
    logs.create(:message => "Initialized #{scm} repository")
    
    scm_object.install_plugins
    logs.create(:message => "Installed #{selected_plugins.count} plugins")
    
    if capify
      system("cd ../#{self.underscored_name} && Capify .")
      logs.create(:message => "Capified with Capistrano")
    end
    
    scm_object.track_all_files
    logs.create(:message => "Tracked all files")
    
    scm_object.push_to_server
    logs.create(:message => "Pushed files to server.  Generation completed.")
    
    update_attributes(:generation_stop_time => Time.now)
    logs.create(:message => 'Finished generate process')
    generation_completed!
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
