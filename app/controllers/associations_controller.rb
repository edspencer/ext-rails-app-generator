class AssociationsController < ApplicationController
  
  before_filter :ensure_logged_in
  before_filter :ensure_site_found
  before_filter :ensure_model_found
  before_filter :ensure_association_found, :only => [:show, :edit, :destroy, :update]
  
  # GET /associations
  # GET /associations.xml
  def index
    @associations = @model.associations.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @associations }
    end
  end

  # GET /associations/1
  # GET /associations/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @association }
    end
  end

  # GET /associations/new
  # GET /associations/new.xml
  def new
    @association = Association.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @association }
    end
  end

  # GET /associations/1/edit
  def edit
  end

  # POST /associations
  # POST /associations.xml
  def create
    @association = Association.new(params[:association])
    @association.model = @model

    respond_to do |format|
      if @association.save
        flash[:notice] = 'Association was successfully created.'
        format.html { redirect_to(edit_site_model_path(@site, @model)) }
        format.xml  { render :xml => @association, :status => :created, :location => @association }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /associations/1
  # PUT /associations/1.xml
  def update
    respond_to do |format|
      if @association.update_attributes(params[:association])
        flash[:notice] = 'Association was successfully updated.'
        format.html { redirect_to(edit_site_model_path(@site, @model)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /associations/1
  # DELETE /associations/1.xml
  def destroy
    @association.destroy

    respond_to do |format|
      format.html { redirect_to(edit_site_model_path(@site, @model)) }
      format.xml  { head :ok }
    end
  end
end
