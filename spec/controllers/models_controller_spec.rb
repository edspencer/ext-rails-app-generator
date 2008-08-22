require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelsController do
  include CrudSetup, SetupMockModels
  
  before(:each) do
    setup_mock_models
    @model_name   = 'Model'
    @parent_model = @site
    setup_crud_names
  end

  def mocked_model(stubs={})
    stubs = {
      :save => true,
      :update_attributes => true,
      :destroy => true,
      :to_xml => '',
      :site => @site,
      :site= => nil
    }.merge(stubs)
    
    @mocked_model ||= mock("Model", stubs)
  end

  describe "responding to GET /sites/:site_id/models" do
    before(:each) do
      @site = mock_model(Site, :id => 1, :models => mock_model(Array, :find => []))
      @sites = mock_model(Array, :find => @site)
      @user = mock_model(User, :id => 1, :sites => @sites)
      
      controller.stub!(:current_user).and_return(@user)
    end
    
    it "should redirect to show site" do
      do_request
      response.should redirect_to(site_path(@site))
    end
    
    def do_request
      get :index, :site_id => @site.id
    end
  end

  describe "responding to GET /sites/:site_id/models.xml" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD GET index (XML)"
    
    def do_request
      get :index, :site_id => @site.id
    end
  end
  
  describe "responding to GET /models/1" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD GET show (HTML)"
    it_should_behave_like "CRUD GET show (XML)"
    
    def do_request
      get :show, :id => 1, :site_id => @site.id
    end
  end
  
  describe "responding to GET /models/new" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD GET new"
    
    def do_request
      get :new, :site_id => @site.id
    end
  end

  describe "responding to GET /models/1/edit" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD GET edit"
    
    def do_request
      get :edit, :id => "1", :site_id => @site.id
    end
  end

  describe "responding to POST /models" do
    before(:each) do
      @stubbed_model.stub!(:site=).and_return(true)
    end
    
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD POST create"
    
    it "should redirect to the created model" do
      @finder_scope.stub!(:new).and_return(@stubbed_model)
      do_request
      response.should redirect_to(site_models_url(@stubbed_model))
    end
        
    def do_request
      post :create, :model => {:these => 'params'}, :site_id => @site.id
    end
  end

  describe "responding to PUT /models/1" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD PUT update"
    
    it "should redirect to the edit model screen after successful update" do
      @stubbed_model.stub!(:save).and_return(true)
      @stubbed_model.stub!(:update_attributes).and_return(true)
      
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      do_request
      response.should redirect_to(site_models_url(@stubbed_model))
    end

    def do_request
      put :update, :id => "1", :model => {:these => 'params'}, :site_id => @site.id
    end
  end
  
  describe "responding to DELETE /models/1" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD DELETE destroy"
    
    it "should redirect to the models list" do
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      do_request
      response.should redirect_to(site_models_url(@site))
    end
    
    def do_request
      delete :destroy, :id => "1", :site_id => @site.id
    end
  
  end

end
