class SitesController < ApplicationController
  
  before_filter :ensure_logged_in
  before_filter :ensure_site_found, :only => [:clone, :create_clone, :generate]
  before_filter :find_plugins, :only => [:new, :edit]
  
  make_resourceful do
    actions :all
    belongs_to :user
    
    before :create do
      @site.user = current_user
    end
    
    response_for :index do |format|
      format.html
      format.xml  { render :xml => @sites}
    end
    
    response_for :show do |format|
      format.html
      format.xml { render :xml => @site}
    end
  end
    
  # additional actions
  def clone
    
  end
  
  def create_clone
    
  end
  
  def generate
    
  end

  protected  
  def find_plugins
    @plugins = Plugin.all
  end
  
  def parent_object
    current_user
  end
  
  private
  
  def current_objects
    @current_objects ||= current_user.sites.paginate :page => params[:page]
  end
  
  # FIXME: we shouldn't have to do this... should be automatic I think?
  def current_object
    @current_object ||= current_user.sites.find(params[:id])
  end
end
