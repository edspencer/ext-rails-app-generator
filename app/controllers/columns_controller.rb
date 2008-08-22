class ColumnsController < ApplicationController
  
  before_filter :ensure_logged_in
  before_filter :ensure_site_found
  before_filter :ensure_model_found
  
  make_resourceful do
    actions :all
    belongs_to :model, :site
    
    after :create do
      @column.model = @model
    end
    
    response_for :index do |format|
      format.html
      format.xml { render :xml => @columns}
    end
    
    response_for :show do |format|
      format.html
      format.xml { render :xml => @column}
    end
    
    response_for :create do |format|
      format.html { redirect_to(edit_site_model_path(@site, @model)) }
      format.xml  { render :xml => @column, :status => :created, :location => site_model_path(@site, @model) }
    end
    
    response_for :update do |format|
      format.html { redirect_to(edit_site_model_path(@site, @model)) }
      format.xml  { head :ok }
    end
    
    response_for :destroy do |format|
      format.html { redirect_to(edit_site_model_path(@site, @model)) }
      format.xml  { head :ok }
    end
  end
      
  private
  # FIXME: we shouldn't have to do this... should be automatic I think?
  def current_object
    @current_object ||= @model.columns.find(params[:id])
  end
  
  def parent_object
    @parent_object ||= @model
  end
end
