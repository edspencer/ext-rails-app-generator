class ModelsController < ApplicationController
  
  before_filter :ensure_logged_in
  before_filter :ensure_site_found
  before_filter :find_model, :only => [:show, :edit, :destroy, :update]
  
  # GET /models
  # GET /models.xml
  def index
    @models = @site.models.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @models }
    end
  end

  # GET /models/1
  # GET /models/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @model = Model.new(:site_id => @site)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/1/edit
  def edit
  end

  # POST /models
  # POST /models.xml
  def create
    @model = Model.new(params[:model])
    @model.site = @site

    respond_to do |format|
      if @model.save
        flash[:notice] = 'Model was successfully created.'
        format.html { redirect_to(site_models_path(@model)) }
        format.xml  { render :xml => @model, :status => :created, :location => @model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.xml
  def update
    respond_to do |format|
      if @model.update_attributes(params[:model])
        flash[:notice] = 'Model was successfully updated.'
        format.html { redirect_to(site_models_path(@model)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    @model.destroy

    respond_to do |format|
      format.html { redirect_to(site_models_path(@model.site)) }
      format.xml  { head :ok }
    end
  end
  
  protected

  def find_model
    @model = @site.models.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.html {flash[:error] = "Sorry, that model could not be found"; redirect_to(site_path(@site))}
    end
  end
end
