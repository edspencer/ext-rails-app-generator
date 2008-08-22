require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AssociationsController do
  include CrudSetup, SetupMockModels

  def mock_association(stubs={})
      stubs = {
      :save => true,
      :update_attributes => true,
      :destroy => true,
      :to_xml => '',
      :model => @model,
      :model= => nil
    }.merge(stubs)
    
    @mock_association ||= mock_model(Association, stubs)
  end
  
  before(:each) do
    setup_mock_models
    @model_name   = 'Association'
    @parent_model = @model
    setup_crud_names
  end
  
  describe "responding to GET index" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    it_should_behave_like "CRUD GET index (HTML)"
    it_should_behave_like "CRUD GET index (XML)"
    
    def do_request
      get :index, :site_id => @site.id, :model_id => @model.id
    end
  end

  describe "responding to GET show" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    it_should_behave_like "CRUD GET show (HTML)"
    it_should_behave_like "CRUD GET show (XML)"
    
    def do_request
      get :show, :id => "1", :site_id => @site.id, :model_id => @model.id
    end
  end
  
  describe "responding to GET new" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    it_should_behave_like "CRUD GET new"
    
    def do_request
      get :new, :site_id => @site.id, :model_id => @model.id
    end
  end
  
  describe "responding to GET edit" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    it_should_behave_like "CRUD GET edit"

    def do_request
      get :edit, :id => "1", :site_id => @site.id, :model_id => @model.id
    end
  end
  
  describe "responding to POST create" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    it_should_behave_like "CRUD POST create"
    
    before(:each) do
      @stubbed_model.stub!(:model=).and_return(true)
    end
    
    it "should redirect to the created model after successful creation" do
      @stubbed_model.stub!(:save).and_return(true)
      @finder_scope.stub!(:new).and_return(@stubbed_model)
      do_request
      response.should redirect_to(edit_site_model_url(@site, @model))
    end
    
    def do_request
      post :create, :association => {:these => 'params'}, :site_id => @site.id, :model_id => @model.id
    end
  end
    
  describe "responding to PUT update" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    it_should_behave_like "CRUD PUT update"
    
    before(:each) do
      @stubbed_model.stub!(:model=).and_return(true)
    end
    
    it "should redirect to the edit model screen after successful update" do
      @stubbed_model.stub!(:save).and_return(true)
      @stubbed_model.stub!(:update_attributes).and_return(true)
      
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      do_request
      response.should redirect_to(edit_site_model_url(@site, @model))
    end
    
    def do_request
      put :update, :id => "1", :association => {:these => 'params'}
    end
  end
  
  describe "responding to DELETE destroy" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    it_should_behave_like "CRUD DELETE destroy"
  
    it "should redirect to the edit model screen" do
      @associations.stub!(:find).and_return(mock_association(:destroy => true))
      do_request
      response.should redirect_to(edit_site_model_path(@site.id, @model.id))
    end
    
    def do_request
      delete :destroy, :id => "1"
    end
  end

end
