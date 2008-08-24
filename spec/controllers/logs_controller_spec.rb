require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LogsController do
  include CrudSetup, SetupMockModels

  def mock_log(stubs={})
      stubs = {
      :save => true,
      :update_attributes => true,
      :destroy => true,
      :to_xml => '',
      :site => @site,
      :site= => nil
    }.merge(stubs)
    
    @mock_log ||= mock_model(Log, stubs)
  end
  
  before(:each) do
    setup_mock_models
    @model_name   = 'log'
    @parent_model = @site
    setup_crud_names
  end

  describe "responding to GET index" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD GET index (HTML)"
    it_should_behave_like "CRUD GET index (XML)"
    
    def do_request
      get :index, :site_id => @site.id
    end
  end
  
  describe "responding to DELETE destroy" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "CRUD DELETE destroy"
  
    it "should redirect to the show site screen" do
      @logs.stub!(:find).and_return(mock_log(:destroy => true))
      do_request
      response.should redirect_to(site_logs_path(@site.id))
    end
    
    def do_request
      delete :destroy, :id => "1", :site_id => @site.id
    end
  end
  
  describe "responding to DELETE clear" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    
    it "should clear the logs" do
      @logs.should_receive(:clear).and_return(true)
      do_request
    end
    
    it "should redirect back to show site" do
      do_request
      response.should redirect_to(site_path(@site))
    end
    
    it "should give a flash notice" do
      do_request
      flash[:notice].should_not be(nil)
    end
    
    def do_request
      delete :clear, :site_id => @site.id
    end
  end

end
