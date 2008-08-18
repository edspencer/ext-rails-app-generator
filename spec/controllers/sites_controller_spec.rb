require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SitesController do

  def mock_site(stubs={})
    @mock_site ||= mock_model(Site, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all sites as @sites" do
      Site.should_receive(:find).with(:all).and_return([mock_site])
      get :index
      assigns[:sites].should == [mock_site]
    end

    describe "with mime type of xml" do
  
      it "should render all sites as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Site.should_receive(:find).with(:all).and_return(sites = mock("Array of Sites"))
        sites.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested site as @site" do
      Site.should_receive(:find).with("37").and_return(mock_site)
      get :show, :id => "37"
      assigns[:site].should equal(mock_site)
    end
    
    describe "with mime type of xml" do

      it "should render the requested site as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Site.should_receive(:find).with("37").and_return(mock_site)
        mock_site.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
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

  describe "responding to GET edit" do
  
    it "should expose the requested site as @site" do
      Site.should_receive(:find).with("37").and_return(mock_site)
      get :edit, :id => "37"
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

      it "should redirect to the created site" do
        Site.stub!(:new).and_return(mock_site(:save => true))
        post :create, :site => {}
        response.should redirect_to(site_url(mock_site))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved site as @site" do
        Site.stub!(:new).with({'these' => 'params'}).and_return(mock_site(:save => false))
        post :create, :site => {:these => 'params'}
        assigns(:site).should equal(mock_site)
      end

      it "should re-render the 'new' template" do
        Site.stub!(:new).and_return(mock_site(:save => false))
        post :create, :site => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested site" do
        Site.should_receive(:find).with("37").and_return(mock_site)
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :site => {:these => 'params'}
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
        Site.should_receive(:find).with("37").and_return(mock_site)
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :site => {:these => 'params'}
      end

      it "should expose the site as @site" do
        Site.stub!(:find).and_return(mock_site(:update_attributes => false))
        put :update, :id => "1"
        assigns(:site).should equal(mock_site)
      end

      it "should re-render the 'edit' template" do
        Site.stub!(:find).and_return(mock_site(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested site" do
      Site.should_receive(:find).with("37").and_return(mock_site)
      mock_site.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the sites list" do
      Site.stub!(:find).and_return(mock_site(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(sites_url)
    end

  end

end
