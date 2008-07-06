require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelsController do

  def mock_model(stubs={})
    @site = mock("Site", :id => 1)
    stubs = {
      :save => true,
      :update_attributes => true,
      :destroy => true,
      :to_xml => '',
      :site => @site
    }.merge(stubs)
    @mock_model ||= mock("Model", stubs)
  end

  describe "responding to GET /models" do

    it "should succeed" do
      Model.stub!(:find)
      get :index
      response.should be_success
    end

    it "should render the 'index' template" do
      Model.stub!(:find)
      get :index
      response.should render_template('index')
    end
  
    it "should find all models" do
      Model.should_receive(:find).with(:all)
      get :index
    end
  
    it "should assign the found models for the view" do
      Model.should_receive(:find).and_return([mock_model])
      get :index
      assigns[:models].should == [mock_model]
    end

  end

  describe "responding to GET /models.xml" do

    before(:each) do
      request.env["HTTP_ACCEPT"] = "application/xml"
    end
  
    it "should succeed" do
      Model.stub!(:find).and_return([])
      get :index
      response.should be_success
    end

    it "should find all models" do
      Model.should_receive(:find).with(:all).and_return([])
      get :index
    end
  
    it "should render the found models as xml" do
      Model.should_receive(:find).and_return(models = mock("Array of Models"))
      models.should_receive(:to_xml).and_return("generated XML")
      get :index
      response.body.should == "generated XML"
    end
    
  end

  describe "responding to GET /models/1" do

    it "should succeed" do
      Model.stub!(:find)
      get :show, :id => "1"
      response.should be_success
    end
  
    it "should render the 'show' template" do
      Model.stub!(:find)
      get :show, :id => "1"
      response.should render_template('show')
    end
  
    it "should find the requested model" do
      Model.should_receive(:find).with("37")
      get :show, :id => "37"
    end
  
    it "should assign the found model for the view" do
      Model.should_receive(:find).and_return(mock_model)
      get :show, :id => "1"
      assigns[:model].should equal(mock_model)
    end
    
  end

  describe "responding to GET /models/1.xml" do

    before(:each) do
      request.env["HTTP_ACCEPT"] = "application/xml"
    end
  
    it "should succeed" do
      Model.stub!(:find).and_return(mock_model)
      get :show, :id => "1"
      response.should be_success
    end
  
    it "should find the model requested" do
      Model.should_receive(:find).with("37").and_return(mock_model)
      get :show, :id => "37"
    end
  
    it "should render the found model as xml" do
      Model.should_receive(:find).and_return(mock_model)
      mock_model.should_receive(:to_xml).and_return("generated XML")
      get :show, :id => "1"
      response.body.should == "generated XML"
    end

  end

  describe "responding to GET /models/new" do

    it "should succeed" do
      get :new
      response.should be_success
    end
  
    it "should render the 'new' template" do
      get :new
      response.should render_template('new')
    end
  
    it "should create a new model" do
      Model.should_receive(:new)
      get :new
    end
  
    it "should assign the new model for the view" do
      Model.should_receive(:new).and_return(mock_model)
      get :new
      assigns[:model].should equal(mock_model)
    end

  end

  describe "responding to GET /models/1/edit" do

    it "should succeed" do
      Model.stub!(:find)
      get :edit, :id => "1"
      response.should be_success
    end
  
    it "should render the 'edit' template" do
      Model.stub!(:find)
      get :edit, :id => "1"
      response.should render_template('edit')
    end
  
    it "should find the requested model" do
      Model.should_receive(:find).with("37")
      get :edit, :id => "37"
    end
  
    it "should assign the found Model for the view" do
      Model.should_receive(:find).and_return(mock_model)
      get :edit, :id => "1"
      assigns[:model].should equal(mock_model)
    end

  end

  describe "responding to POST /models" do

    describe "with successful save" do
  
      it "should create a new model" do
        Model.should_receive(:new).with({'these' => 'params'}).and_return(mock_model)
        post :create, :model => {:these => 'params'}
      end

      it "should assign the created model for the view" do
        Model.stub!(:new).and_return(mock_model)
        post :create, :model => {}
        assigns(:model).should equal(mock_model)
      end

      it "should redirect to the created model" do
        Model.stub!(:new).and_return(mock_model)
        post :create, :model => {}
        response.should redirect_to(model_url(mock_model))
      end
      
    end
    
    describe "with failed save" do

      it "should create a new model" do
        Model.should_receive(:new).with({'these' => 'params'}).and_return(mock_model(:save => false))
        post :create, :model => {:these => 'params'}
      end

      it "should assign the invalid model for the view" do
        Model.stub!(:new).and_return(mock_model(:save => false))
        post :create, :model => {}
        assigns(:model).should equal(mock_model)
      end

      it "should re-render the 'new' template" do
        Model.stub!(:new).and_return(mock_model(:save => false))
        post :create, :model => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT /models/1" do

    describe "with successful update" do

      it "should find the requested model" do
        Model.should_receive(:find).with("37").and_return(mock_model)
        put :update, :id => "37"
      end

      it "should update the found model" do
        Model.stub!(:find).and_return(mock_model)
        mock_model.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "1", :model => {:these => 'params'}
      end

      it "should assign the found model for the view" do
        Model.stub!(:find).and_return(mock_model)
        put :update, :id => "1"
        assigns(:model).should equal(mock_model)
      end

      it "should redirect to the model" do
        Model.stub!(:find).and_return(mock_model)
        put :update, :id => "1"
        response.should redirect_to(model_url(mock_model))
      end

    end
    
    describe "with failed update" do

      it "should find the requested model" do
        Model.should_receive(:find).with("37").and_return(mock_model(:update_attributes => false))
        put :update, :id => "37"
      end

      it "should update the found model" do
        Model.stub!(:find).and_return(mock_model)
        mock_model.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "1", :model => {:these => 'params'}
      end

      it "should assign the found model for the view" do
        Model.stub!(:find).and_return(mock_model(:update_attributes => false))
        put :update, :id => "1"
        assigns(:model).should equal(mock_model)
      end

      it "should re-render the 'edit' template" do
        Model.stub!(:find).and_return(mock_model(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE /models/1" do

    it "should find the model requested" do
      Model.should_receive(:find).with("37").and_return(mock_model)
      delete :destroy, :id => "37"
    end
  
    it "should call destroy on the found model" do
      Model.stub!(:find).and_return(mock_model)
      mock_model.should_receive(:destroy)
      delete :destroy, :id => "1"
    end
  
    it "should redirect to the models list" do
      Model.stub!(:find).and_return(mock_model)
      delete :destroy, :id => "1"
      response.should redirect_to(site_models_url(mock_model.site))
    end

  end

end
