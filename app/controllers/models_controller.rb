class ModelsController < ApplicationController
  
  before_filter :ensure_logged_in
  before_filter :ensure_site_found
  
  make_resourceful do
    actions :all
    belongs_to :site
    
    before :create do
      @model.site = @site
    end
    
    response_for :index do |format|
      format.html { redirect_to(@site)}
      format.xml  { render :xml => @models}
    end
    
    response_for :show do |format|
      format.html
      format.xml { render :xml => @model}
    end
    
    response_for :create do |format|
      format.html { redirect_to(site_models_path(@model)) }
      format.xml  { render :xml => @model, :status => :created, :location => @model }
    end
    
    response_for :update do |format|
      format.html { redirect_to(site_models_path(@model)) }
      format.xml  { head :ok }
    end
    
    response_for :destroy do |format|
      format.html { redirect_to(site_models_path(@site)) }
      format.xml  { head :ok }
    end
  end
  
  private
  #found by ensure_site_found, so cache here for make_resourceful
  def parent_object
    @site
  end

end
