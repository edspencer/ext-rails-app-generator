# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all

  protect_from_forgery # :secret => 'f81f262e030aa9ca4d8ef9dfb8ecf584'
  
  filter_parameter_logging :password
  
  protected
  def ensure_logged_in
    unless logged_in?
      respond_to do |format|
        format.html {flash[:error] = 'You are not logged in, please log in below'; redirect_to('/')}
      
        #TODO: see http://midlandsweb.lighthouseapp.com/projects/15705-rails-application-generator/tickets/2
        format.xml  {flash[:error] = 'You are not logged in, please log in below'; redirect_to('/')}
      end
    end
  end
  
  # be sure to ensure_logged_in before this
  def ensure_site_found
    @site = current_user.sites.find(params[:site_id] || params[:id])
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.html {flash[:error] = "Couldn't find that site"; redirect_to(sites_path);}
      
      #TODO: see http://midlandsweb.lighthouseapp.com/projects/15705-rails-application-generator/tickets/2
      format.xml  {flash[:error] = "Couldn't find that site"; redirect_to(sites_path);}
    end
  end
end
