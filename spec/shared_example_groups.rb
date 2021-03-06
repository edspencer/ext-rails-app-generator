require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module SetupMockModels
  def setup_mock_models
    @association  = mock_model(Association, :id => 1, :null_object => true)
    @associations = mock_model(Array, :find => @association)
    
    @validation   = mock_model(Validation, :id => 1, :null_object => true)
    @validations  = mock_model(Array, :find => @validation)
    
    @model  = mock_model(Model, :id => 1, :null_object => true)
    @models = mock_model(Array, :find => @model)
    
    @log  = mock_model(Log, :id => 1, :null_object => true)
    @logs = mock_model(Array, :find => @log, :clear => nil)
    
    @site  = mock_model(Site, :id => 1, :null_object => true)
    @sites = mock(Array, :find => @site, :paginate => [@site])
    
    @model.stub!(:associations).and_return(@associations)
    @model.stub!(:validations).and_return(@validations)
    @site.stub!(:models).and_return(@models)
    @site.stub!(:logs).and_return(@logs)
    
    @user = mock_model(User, :id => 1, :sites => @sites)
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
  end
end

describe "Ensures logged in", :shared => true do
  it "should allow the request to proceed if logged in" do
    do_request
    
    if request.env["REQUEST_METHOD"] == "GET"
      response.should be_success
    else
      response.should be_redirect
    end
  end
  
  describe "if not logged in" do
    before(:each) do
      controller.stub!(:current_user).and_return(:false)
      controller.stub!(:logged_in?).and_return(false)
    end
    
    it "should redirect to the home page" do
      do_request
      response.should redirect_to('/')
    end
    
    it "should display a flash error" do
      do_request
      flash[:error].should_not be(nil)
    end
  end
end

describe "Ensures site found", :shared => true do
  describe "if the site is found" do
    before(:each) do
      @sites.stub!(:find).and_return(@site)
    end
    
    it "should allow the request to proceed" do
      @sites.should_receive(:find).with(@site.id.to_s).and_return(@site)
      
      do_request
      
      if request.env["REQUEST_METHOD"] == "GET"
        response.should be_success
      else
        response.should be_redirect
      end
    end
  end
  
  describe "if the site is not found" do
    before(:each) do
      @sites.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end
    
    it "should display a flash message" do
      do_request
      flash[:error].should_not be(nil)
    end
    
    it "should redirect to sites path" do
      do_request
      response.should redirect_to(sites_path)
    end
  end
end

describe "Ensures model found", :shared => true do
  describe "if the model is found" do
    before(:each) do
      @models.stub!(:find).and_return(@model)
    end
    
    it "should allow the request to proceed" do
      @models.should_receive(:find).with(@model.id.to_s).and_return(@model)
      
      do_request
      
      if request.env["REQUEST_METHOD"] == "GET"
        response.should be_success
      else
        response.should be_redirect
      end
    end
  end
  
  describe "if the model is not found" do
    before(:each) do
      @models.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end
    
    it "should display a flash message" do
      do_request
      flash[:error].should_not be(nil)
    end
    
    it "should redirect to models path" do
      do_request
      response.should redirect_to(site_models_path(@site))
    end
  end
end