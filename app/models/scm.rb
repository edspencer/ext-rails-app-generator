# Feeble attempt at creating an Interface in Ruby - better way, anyone?
class Scm
  attr_reader :site
  cattr_reader :registered_scms
  cattr_reader :scm_name
  
  def initialize(site)
    @site = site
  end
    
  # You need to implement each of the methods called below
  def generate!
    initialize_repository
    install_plugins
    track_all_files
    push_to_server
  end
    
  # Set up Scm to behave like a factory - register each subclass here
  @@registered_scms = {}
  def self.register_scm klass, name
    @@registered_scms[name] = klass
  end
  
  def self.inherited(subclass)
    register_scm(subclass, subclass.to_s.downcase)
  end
  
  def self.new_scm name, options = {}
    @@registered_scms[name].new(options) unless @@registered_scms[name].blank?
  end
  
  def self.clear_registered_scms
    @@registered_scms = {}
  end
  
  protected
  # Just use normal install script.  Should override this for submodules/piston
  def install_plugins
    @site.selected_plugins.each do |p|
      # ruby script/plugin install p.plugin.remote_url
    end
  end

end