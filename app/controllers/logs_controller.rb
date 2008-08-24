class LogsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :ensure_site_found
  
  make_resourceful do
    actions :index, :destroy
    belongs_to :site
    
    response_for :index do |format|
      format.html
      format.xml  { render :xml => @logs}
    end
  end
  
  def clear
    @site.logs.clear
    flash[:notice] = "Logs have been cleared for this site"
    
    redirect_to @site
  end
  
  private
  #found by ensure_site_found, so cache here for make_resourceful
  def parent_object
    @site
  end
end