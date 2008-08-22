require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SitesController do
  
  def mock_site(stubs={})
    stubs = {:id => 123, 
             :save => true,
             :user= => true,
             :update_attributes => true,
             :destroy => true}.merge(stubs)

    @mock_site ||= mock_model(Site, stubs)
  end
  
  describe "responding to GET index" do
    it_should_behave_like "Ensures logged in"

    it "should expose all sites as @sites" do
      @sites.should_receive(:paginate).with(:page => nil).and_return([@site])
      do_request
      assigns[:sites].should == [@site]
    end

    describe "with mime type of xml" do
      
      it "should render all sites as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @sites.should_receive(:paginate).with(:page => nil).and_return(sites = mock("Array of Sites"))
        sites.should_receive(:to_xml).and_return("generated XML")
        do_request
        response.body.should == "generated XML"
      end
    
    end
    
    def do_request
      get :index
    end

  end

  describe "responding to GET show" do
    it_should_behave_like "Ensures logged in"

    it "should expose the requested site as @site" do
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      do_request
      assigns[:site].should equal(mock_site)
    end
    
    describe "with mime type of xml" do

      it "should render the requested site as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
        mock_site.should_receive(:to_xml).and_return("generated XML")
        do_request
        response.body.should == "generated XML"
      end

    end
    
    def do_request
      get :show, :id => mock_site.id
    end
    
  end

  describe "responding to GET new" do
    it_should_behave_like "Ensures logged in"
  
    it "should expose a new site as @site" do
      Site.should_receive(:new).and_return(mock_site)
      do_request
      assigns[:site].should equal(mock_site)
    end
    
    def do_request
      get :new
    end

  end
  
  describe "responding to GET clone" do
    it_should_behave_like "Ensures logged in"
    
    it "should find the site" do
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      do_request
    end
    
    it "should render the clone template" do
      do_request
      response.should render_template(:clone)
    end
    
    it "should be successful" do
      do_request
      response.should be_success
    end
    
    def do_request
      get :clone, :id => mock_site.id
    end
  end
  
  describe "responding to POST create_clone" do
    # TODO: re-enable when this is implemented
    # it_should_behave_like "Ensures logged in"
    
    it "should find the site" do
      pending("implement this")
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      do_request
    end
    
    def do_request
      post :create_clone, :id => mock_site.id
    end
  end
  
  describe "responding to POST generate" do
    # TODO: re-enable when this is implemented
    # it_should_behave_like "Ensures logged in"
    
    it "should find the site" do
      pending("implement this")
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      do_request
    end
    
    def do_request
      post :generate, :id => mock_site.id
    end
  end
  
  describe "responding to GET edit" do
    it_should_behave_like "Ensures logged in"
  
    it "should expose the requested site as @site" do
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      do_request
      assigns[:site].should equal(mock_site)
    end
    
    def do_request
      get :edit, :id => mock_site.id
    end
  
  end
  
  describe "responding to POST create" do
    before(:each) do
      Site.stub!(:new).and_return(mock_site)
    end
    
    it_should_behave_like "Ensures logged in"
  
    describe "with valid params" do
      
      it "should expose a newly created site as @site" do
        Site.should_receive(:new).with({'these' => 'params'}).and_return(mock_site(:save => true))
        do_request
        assigns(:site).should equal(mock_site)
      end
      
      it "should assign the site to the currently logged in user" do
        Site.stub!(:new).and_return(mock_site(:save => true))
        mock_site.should_receive(:user=).with(@user)
        do_request
      end
  
      it "should redirect to the created site" do
        Site.stub!(:new).and_return(mock_site(:save => true))
        do_request
        response.should redirect_to(site_url(mock_site))
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @bad_site = mock_model(Site, :save => false, :user= => true)
      end
  
      it "should expose a newly created but unsaved site as @site" do
        Site.stub!(:new).with({'these' => 'params'}).and_return(@bad_site)
        do_request
        assigns(:site).should equal(@bad_site)
      end
  
      it "should re-render the 'new' template" do
        Site.stub!(:new).and_return(@bad_site)
        do_request
        response.should render_template('new')
      end
      
    end
    
    def do_request
      post :create, :site => {:these => 'params'}
    end
  end
  
  describe "responding to PUT update" do
    it_should_behave_like "Ensures logged in"
  
    describe "with valid params" do
  
      it "should update the requested site" do
        @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        do_request
      end
  
      it "should expose the requested site as @site" do
        @sites.stub!(:find).and_return(@site)
        do_request
        assigns(:site).should equal(@site)
      end
  
      it "should redirect to the site" do
        @sites.stub!(:find).and_return(@site)
        do_request
        response.should redirect_to(site_url(@site))
      end
  
    end
    
    describe "with invalid params" do
  
      it "should update the requested site" do
        @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        do_request
      end
  
      it "should expose the site as @site" do
        @sites.stub!(:find).and_return(mock_site(:update_attributes => false))
        do_request
        assigns(:site).should equal(mock_site)
      end
  
      it "should re-render the 'edit' template" do
        bad_site = mock_model(Site, :update_attributes => false)
        @sites.stub!(:find).and_return(bad_site)
        do_request
        response.should render_template('edit')
      end
  
    end
    
    def do_request
      put :update, :id => mock_site.id, :site => {:these => 'params'}
    end
  
  end
  
  describe "responding to DELETE destroy" do
    it_should_behave_like "Ensures logged in"
  
    it "should destroy the requested site" do
      @sites.should_receive(:find).with(@site.id.to_s).and_return(@site)
      @site.should_receive(:destroy).and_return(true)
      do_request
    end
  
    it "should redirect to the sites list" do
      @sites.stub!(:find).and_return(@site)
      do_request
      response.should redirect_to(sites_url)
    end
    
    def do_request
      delete :destroy, :id => @site.id
    end
  
  end

end
