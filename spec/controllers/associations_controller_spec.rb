require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AssociationsController do

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
  
  describe "responding to GET index" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"

    it "should expose all associations as @associations" do
      @associations.should_receive(:find).with(:all).and_return([mock_association])
      do_request
      assigns[:associations].should == [mock_association]
    end

    describe "with mime type of xml" do
  
      it "should render all associations as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @associations.should_receive(:find).with(:all).and_return(associations = mock("Array of Associations"))
        associations.should_receive(:to_xml).and_return("generated XML")
        do_request
        response.body.should == "generated XML"
      end
    
    end
    
    def do_request
      get :index, :site_id => @site.id, :model_id => @model.id
    end

  end

  describe "responding to GET show" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
  
    it "should expose the requested association as @association" do
      @associations.should_receive(:find).with("1").and_return(mock_association)
      do_request
      assigns[:association].should equal(mock_association)
    end
    
    describe "with mime type of xml" do
  
      it "should render the requested association as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @associations.should_receive(:find).with("1").and_return(mock_association)
        mock_association.should_receive(:to_xml).and_return("generated XML")
        do_request
        response.body.should == "generated XML"
      end
  
    end
    
    def do_request
      get :show, :id => "1", :site_id => @site.id, :model_id => @model.id
    end
    
  end
  
  describe "responding to GET new" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
  
    it "should expose a new association as @association" do
      Association.should_receive(:new).and_return(mock_association)
      do_request
      assigns[:association].should equal(mock_association)
    end
    
    def do_request
      get :new, :site_id => @site.id, :model_id => @model.id
    end
  
  end
  
  describe "responding to GET edit" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
  
    it "should expose the requested association as @association" do
      @associations.should_receive(:find).with("1").and_return(mock_association)
      do_request
      assigns[:association].should equal(mock_association)
    end
    
    def do_request
      get :edit, :id => "1", :site_id => @site.id, :model_id => @model.id
    end
  
  end

  describe "responding to POST create" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"
    
    before(:each) do
      Association.stub!(:new).and_return(mock_association(:save => true))
    end
  
    describe "with valid params" do
      
      it "should expose a newly created association as @association" do
        Association.should_receive(:new).with({'these' => 'params'}).and_return(mock_association(:save => true))
        do_request
        assigns(:association).should equal(mock_association)
      end

      it "should redirect to the created association" do
        Association.stub!(:new).and_return(mock_association(:save => true))
        do_request
        response.should redirect_to(edit_site_model_path(@site.id, @model.id))
      end
      
      it "should link the association with the model" do
        mock_association.should_receive(:model=).with(@model).and_return(true)
        do_request
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved association as @association" do
        Association.stub!(:new).with({'these' => 'params'}).and_return(mock_association(:save => false))
        post :create, :association => {:these => 'params'}
        assigns(:association).should equal(mock_association)
      end

      it "should re-render the 'new' template" do
        mock_association.stub!(:save).and_return(false)
        do_request
        response.should render_template('new')
      end
      
    end
    
    def do_request
      post :create, :association => {:these => 'params'}, :site_id => @site.id, :model_id => @model.id
    end
    
  end

  describe "responding to PUT update" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"

    describe "with valid params" do

      it "should update the requested association" do
        @associations.should_receive(:find).with("1").and_return(mock_association)
        mock_association.should_receive(:update_attributes).with({'these' => 'params'})
        do_request
      end

      it "should expose the requested association as @association" do
        @associations.stub!(:find).and_return(mock_association(:update_attributes => true))
        do_request
        assigns(:association).should equal(mock_association)
      end

      it "should redirect to the association" do
        @associations.stub!(:find).and_return(mock_association(:update_attributes => true))
        do_request
        response.should redirect_to(edit_site_model_path(@site.id, @model.id))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested association" do
        @associations.should_receive(:find).with("1").and_return(mock_association)
        mock_association.should_receive(:update_attributes).with({'these' => 'params'})
        do_request
      end

      it "should expose the association as @association" do
        @associations.stub!(:find).and_return(mock_association(:update_attributes => false))
        do_request
        assigns(:association).should equal(mock_association)
      end

      it "should re-render the 'edit' template" do
        @associations.stub!(:find).and_return(mock_association(:update_attributes => false))
        do_request
        response.should render_template('edit')
      end

    end
    
    def do_request
      put :update, :id => "1", :association => {:these => 'params'}
    end

  end

  describe "responding to DELETE destroy" do
    it_should_behave_like "Ensures logged in"
    it_should_behave_like "Ensures site found"
    it_should_behave_like "Ensures model found"

    it "should destroy the requested association" do
      @associations.should_receive(:find).with("1").and_return(mock_association)
      mock_association.should_receive(:destroy)
      do_request
    end
  
    it "should redirect to the associations list" do
      @associations.stub!(:find).and_return(mock_association(:destroy => true))
      do_request
      response.should redirect_to(edit_site_model_path(@site.id, @model.id))
    end
    
    def do_request
      delete :destroy, :id => "1"
    end

  end

end
