require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module SetupUserAndSite
  def do_setup
    @site  = mock_model(Site, :id => 1, :null_object => true)
    @sites = mock(Array, :find => @site)
    
    @user = mock_model(User, :id => 1, :sites => @sites)
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
  end
end

describe "Ensures logged in", :shared => true do
  include SetupUserAndSite
  
  before(:each) do
    do_setup
  end
  
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
  before(:each) do
    do_setup
  end
  
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