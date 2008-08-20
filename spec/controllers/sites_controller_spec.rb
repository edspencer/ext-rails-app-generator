require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SitesController do
  
  def mock_site(stubs={})
    @mock_site ||= mock_model(Site, {:id => 123, :save => true, :user= => true,
                                     :update_attributes => true, :destroy => true}.merge(stubs))
  end

  before(:each) do
    @sites = [mock_site]
    
    @sites.stub!(:paginate).and_return(@sites)
    @sites.stub!(:find).and_return(mock_site)
    
    @user  = mock_model(User, :id => 1, :sites => @sites)
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "responding to GET index" do

    it "should expose all sites as @sites" do
      @sites.should_receive(:paginate).with(:page => nil).and_return(@sites)
      get :index
      assigns[:sites].should == [mock_site]
    end

    describe "with mime type of xml" do
      
      it "should render all sites as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @sites.should_receive(:paginate).with(:page => nil).and_return(sites = mock("Array of Sites"))
        sites.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested site as @site" do
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      get :show, :id => mock_site.id
      assigns[:site].should equal(mock_site)
    end
    
    describe "with mime type of xml" do

      it "should render the requested site as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
        mock_site.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => mock_site.id
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new site as @site" do
      Site.should_receive(:new).and_return(mock_site)
      get :new
      assigns[:site].should equal(mock_site)
    end

  end
  
  describe "responding to GET clone" do
    it "should find the site" do
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      do_get
    end
    
    it "should render the clone template" do
      do_get
      response.should render_template(:clone)
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    def do_get
      get :clone, :id => mock_site.id
    end
  end

  describe "responding to GET edit" do
  
    it "should expose the requested site as @site" do
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      get :edit, :id => mock_site.id
      assigns[:site].should equal(mock_site)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created site as @site" do
        Site.should_receive(:new).with({'these' => 'params'}).and_return(mock_site(:save => true))
        post :create, :site => {:these => 'params'}
        assigns(:site).should equal(mock_site)
      end
      
      it "should assign the site to the currently logged in user" do
        Site.stub!(:new).and_return(mock_site(:save => true))
        mock_site.should_receive(:user=).with(@user)
        post :create
      end

      it "should redirect to the created site" do
        Site.stub!(:new).and_return(mock_site(:save => true))
        post :create, :site => {}
        response.should redirect_to(site_url(mock_site))
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @bad_site = mock_model(Site, :save => false, :user= => true)
      end

      it "should expose a newly created but unsaved site as @site" do
        Site.stub!(:new).with({'these' => 'params'}).and_return(@bad_site)
        post :create, :site => {:these => 'params'}
        assigns(:site).should equal(@bad_site)
      end

      it "should re-render the 'new' template" do
        Site.stub!(:new).and_return(@bad_site)
        post :create, :site => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested site" do
        @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => mock_site.id, :site => {:these => 'params'}
      end

      it "should expose the requested site as @site" do
        Site.stub!(:find).and_return(mock_site(:update_attributes => true))
        put :update, :id => "1"
        assigns(:site).should equal(mock_site)
      end

      it "should redirect to the site" do
        Site.stub!(:find).and_return(mock_site(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(site_url(mock_site))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested site" do
        @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => mock_site.id, :site => {:these => 'params'}
      end

      it "should expose the site as @site" do
        @sites.stub!(:find).and_return(mock_site(:update_attributes => false))
        put :update, :id => "1"
        assigns(:site).should equal(mock_site)
      end

      it "should re-render the 'edit' template" do
        bad_site = mock_model(Site, :update_attributes => false)
        @sites.stub!(:find).and_return(bad_site)
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested site" do
      @sites.should_receive(:find).with(mock_site.id.to_s).and_return(mock_site)
      mock_site.should_receive(:destroy)
      delete :destroy, :id => mock_site.id
    end
  
    it "should redirect to the sites list" do
      Site.stub!(:find).and_return(mock_site(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(sites_url)
    end

  end

end
