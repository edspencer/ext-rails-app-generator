# Feeble attempt at creating an Interface in Ruby - better way, anyone?
class Scm

  attr_reader :site
  
  def initialize(site)
    @site = site
  end
  
  # You need to implement each of the methods called below
  def generate!
    initialize_repository
    remove_unwanted_files
    install_plugins
    track_all_files
    push_to_server
  end
  
  protected
  # Just use normal install script.  Should override this for submodules/piston
  def install_plugins
    @site.selected_plugins.each do |p|
      # ruby script/plugin install p.plugin.remote_url
    end
  end

end