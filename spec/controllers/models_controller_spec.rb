require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelsController do

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

  describe "responding to GET /models.xml" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
  
    before(:each) do
      request.env["HTTP_ACCEPT"] = "application/xml"
    end
  
    it "should succeed" do
      do_request
      response.should be_success
    end

    it "should find all models" do
      @site.models.should_receive(:find).with(:all)
      do_request
    end
  
    it "should render the found models as xml" do
      @site.models.should_receive(:find).and_return(models = mock("Array of Models"))
      models.should_receive(:to_xml).and_return("generated XML")
      do_request
      response.body.should == "generated XML"
    end
    
    def do_request
      get :index, :site_id => @site.id
    end
    
  end
  
  describe "responding to GET /models/1" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"

    it "should succeed" do
      do_request
      response.should be_success
    end
  
    it "should render the 'show' template" do
      do_request
      response.should render_template('show')
    end
  
    it "should find the requested model" do
      @site.models.should_receive(:find).with("1")
      do_request
    end
  
    it "should assign the found model for the view" do
      @site.models.should_receive(:find).and_return(mocked_model)
      do_request
      assigns[:model].should equal(mocked_model)
    end
    
    def do_request
      get :show, :id => 1, :site_id => @site.id
    end
    
  end

  describe "responding to GET /models/1.xml" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"

    before(:each) do
      request.env["HTTP_ACCEPT"] = "application/xml"
    end
  
    it "should succeed" do
      @site.models.stub!(:find)
      do_request
      response.should be_success
    end
  
    it "should find the model requested" do
      @site.models.should_receive(:find).with("1").and_return(mocked_model)
      do_request
    end
  
    it "should render the found model as xml" do
      @site.models.should_receive(:find).and_return(mocked_model)
      mocked_model.should_receive(:to_xml).and_return("generated XML")
      do_request
      response.body.should == "generated XML"
    end
    
    def do_request
      get :show, :id => "1", :site_id => @site.id
    end

  end
  
  describe "responding to GET /models/new" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    
    before(:each) do
      @models.stub!(:new).and_return(mocked_model)
    end
    
    it "should succeed" do
      do_request
      response.should be_success
    end
  
    it "should render the 'new' template" do
      do_request
      response.should render_template('new')
    end
  
    it "should create a new model" do
      @models.should_receive(:new)
      do_request
    end
  
    it "should assign the new model for the view" do
      @models.should_receive(:new).and_return(mocked_model)
      do_request
      assigns[:model].should equal(mocked_model)
    end
    
    def do_request
      get :new, :site_id => @site.id
    end

  end

  describe "responding to GET /models/1/edit" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    
    it "should succeed" do
      @site.models.stub!(:find)
      do_request
      response.should be_success
    end
  
    it "should render the 'edit' template" do
      @site.models.stub!(:find)
      do_request
      response.should render_template('edit')
    end
  
    it "should find the requested model" do
      @site.models.should_receive(:find).with("1")
      do_request
    end
  
    it "should assign the found Model for the view" do
      @site.models.should_receive(:find).and_return(mocked_model)
      do_request
      assigns[:model].should equal(mocked_model)
    end
    
    def do_request
      get :edit, :id => "1", :site_id => @site.id
    end

  end

  describe "responding to POST /models" do  
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    
    before(:each) do
      @models.stub!(:new).and_return(mocked_model)
    end
    
    describe "with successful save" do
  
      it "should create a new model" do
        @models.should_receive(:new).with({'these' => 'params'}).and_return(mocked_model)
        do_request
      end
      
      it "should assign the model to the current site" do
        @models.stub!(:new).and_return(mocked_model)
        mocked_model.should_receive(:site=).with(@site).and_return(true)
        do_request
      end

      it "should assign the created model for the view" do
        @models.stub!(:new).and_return(mocked_model)
        do_request
        assigns(:model).should equal(mocked_model)
      end

      it "should redirect to the created model" do
        @models.stub!(:new).and_return(mocked_model)
        do_request
        response.should redirect_to(site_models_url(mocked_model))
      end
      
    end
    
    describe "with failed save" do
    
      it "should create a new model" do
        @models.should_receive(:new).with({'these' => 'params'}).and_return(mocked_model(:save => false))
        do_request
      end
    
      it "should assign the invalid model for the view" do
        @models.stub!(:new).and_return(mocked_model(:save => false))
        do_request
        assigns(:model).should equal(mocked_model)
      end
    
      it "should re-render the 'new' template" do
        mocked_model.stub!(:save).and_return(false)
        @models.stub!(:new).and_return(mocked_model)
        do_request
        response.should render_template('new')
      end
      
    end
    
    def do_request
      post :create, :model => {:these => 'params'}, :site_id => @site.id
    end
    
  end

  describe "responding to PUT /models/1" do
    
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"

    describe "with successful update" do

      it "should find the requested model" do
        @site.models.should_receive(:find).with("1").and_return(mocked_model)
        do_request
      end

      it "should update the found model" do
        @site.models.stub!(:find).and_return(mocked_model)
        mocked_model.should_receive(:update_attributes).with({'these' => 'params'})
        do_request
      end

      it "should assign the found model for the view" do
        @site.models.stub!(:find).and_return(mocked_model)
        do_request
        assigns(:model).should equal(mocked_model)
      end

      it "should redirect to the model" do
        @site.models.stub!(:find).and_return(mocked_model)
        do_request
        response.should redirect_to(site_models_url(mocked_model))
      end

    end
    
    describe "with failed update" do

      it "should find the requested model" do
        @site.models.should_receive(:find).with("1").and_return(mocked_model(:update_attributes => false))
        do_request
      end

      it "should update the found model" do
        @site.models.stub!(:find).and_return(mocked_model)
        mocked_model.should_receive(:update_attributes).with({'these' => 'params'})
        do_request
      end

      it "should assign the found model for the view" do
        @site.models.stub!(:find).and_return(mocked_model(:update_attributes => false))
        do_request
        assigns(:model).should equal(mocked_model)
      end

      it "should re-render the 'edit' template" do
        @site.models.stub!(:find).and_return(mocked_model(:update_attributes => false))
        do_request
        response.should render_template('edit')
      end

    end
    
    def do_request
      put :update, :id => "1", :model => {:these => 'params'}, :site_id => @site.id
    end

  end
  
  describe "responding to DELETE /models/1" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    
    it "should find the model requested" do
      @site.models.should_receive(:find).with("1").and_return(mocked_model)
      do_request
    end
  
    it "should call destroy on the found model" do
      @site.models.stub!(:find).and_return(mocked_model)
      mocked_model.should_receive(:destroy).and_return(true)
      do_request
    end
  
    it "should redirect to the models list" do
      @site.models.stub!(:find).and_return(mocked_model)
      do_request
      response.should redirect_to(site_models_url(mocked_model.site))
    end
    
    def do_request
      delete :destroy, :id => "1", :site_id => @site.id
    end
  
  end

end
