module CrudSetup
  def setup_crud_names
    # set up the variables we'll refer to in all specs below.
    # If we had an AssetsController, these would map to:
    # @model_name => 'Asset'
    # @model_klass => Asset
    # @model_symbol => :Asset
    # @pluralized_model_name => 'Assets'
    # @assigns_model_name => :asset
    # @pluralized_assigns_model_name => :assets
    @model_name = @model_name.classify
    @model_klass = @model_name.constantize
    @model_symbol = @model_name.to_sym
    @pluralized_model_name = @model_name.humanize.pluralize
    @assigns_model_name = @model_name.underscore.to_sym
    @pluralized_assigns_model_name = @model_name.underscore.pluralize.to_sym
    
    # continuing AssetsController example, this maps to:
    # @stubbed_model => mock_model(Asset, :id => 1)
    # @stubbed_model_collection => [@stubbed_model]
    # Asset.stub!(:find).and_return(@stubbed_model_collection)
    @stubbed_model = mock(@model_name, :id => 1, :to_xml => 'XML', :mock_object => true, :destroy => true, :save => true)
    @stubbed_model_collection = [@stubbed_model]
    @model_klass.stub!(:find).with(:all).and_return(@stubbed_model_collection)
    
    # e.g. Asset.stub!(:count).and_return(@count)
    @count = 10
    @model_klass.stub!(:count).and_return(@count)    
  end
  
  def setup_parent_model_scope
    if @parent_model
      @finder_scope = @parent_model.send(@pluralized_assigns_model_name)
    else
      @finder_scope = @model_klass
    end
  end
  
  def build_param_hash
    params = {:id => @stubbed_model.id}
    if @parent_model
      #e.g. if @parent_model is a MagicWidget model, :magic_widget_id => 1
      params.merge({"#{@parent_model.class.to_s.underscore}_id".intern => @parent_model.id})
    end
    
    params
  end
end

describe "CRUD GET index (HTML)", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_parent_model_scope
  end
  
  it "should succeed" do
    do_request
    response.should be_success
  end

  it "should find all models" do
    @finder_scope.should_receive(:find).with(:all).and_return(@stubbed_model_collection)
    do_request
    assigns[@pluralized_assigns_model_name].should == @stubbed_model_collection
  end

  it "should render the index template" do
    #need to reset this to text/html as it seems setting it to application/xml below
    #crosses over into this example too...
    request.env["HTTP_ACCEPT"] = "text/html"
    @finder_scope.should_receive(:find).and_return(@stubbed_model_collection)
    do_request
    response.should render_template('index')
  end
  
  # guess at the request if not present
  def method_missing name, *args
    if name.to_s == 'do_request'
      get :index, build_param_hash
    else
      super
    end
  end
end

describe "CRUD GET index (XML)", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_parent_model_scope
    request.env["HTTP_ACCEPT"] = "application/xml"
  end
  
  it "should succeed" do
    do_request
    response.should be_success
  end

  it "should find all models" do
    @finder_scope.should_receive(:find).with(:all)
    do_request
  end

  it "should render the found models as xml" do
    @finder_scope.should_receive(:find).and_return(models = mock("Array of Models"))
    models.should_receive(:to_xml).and_return("generated XML")
    do_request
    response.body.should == "generated XML"
  end
  
  # guess at the request if not present
  def method_missing name, *args
    if name.to_s == 'do_request'
      get :index, build_param_hash
    else
      super
    end
  end
end

describe "CRUD GET show (HTML)", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
    setup_parent_model_scope
  end
  
  it "should succeed" do
    do_request
    response.should be_success
  end

  it "should render the 'show' template" do
    do_request
    response.should render_template('show')
  end

  it "should find the requested model" do
    @finder_scope.should_receive(:find).with("1")
    do_request
  end

  it "should assign the found model for the view" do
    @finder_scope.should_receive(:find).and_return(@stubbed_model)
    do_request
    assigns[@assigns_model_name].should equal(@stubbed_model)
  end
  
  # guess at the request if not present
  def method_missing name, *args
    if name.to_s == 'do_request'
      get :show, build_param_hash
    else
      super
    end
  end
end

describe "CRUD GET show (XML)", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
    setup_parent_model_scope
  end

  it "should succeed" do
    @finder_scope.stub!(:find)
    do_request
    response.should be_success
  end

  it "should find the model requested" do
    @finder_scope.should_receive(:find).with("1").and_return(@stubbed_model)
    do_request
  end

  it "should render the found model as xml" do
    request.env["HTTP_ACCEPT"] = "application/xml"
    @finder_scope.should_receive(:find).and_return(@stubbed_model)
    @stubbed_model.should_receive(:to_xml).and_return("generated XML")
    do_request
    response.body.should == "generated XML"
  end
  
  # guess at the request if not present
  def method_missing name, *args
    if name.to_s == 'do_request'
      get :show, build_param_hash
    else
      super
    end
  end
end

describe "CRUD GET new", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_parent_model_scope
    
    @finder_scope.stub!(:new).and_return(@stubbed_model)
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
    @finder_scope.should_receive(:new)
    do_request
  end

  it "should assign the new model for the view" do
    @finder_scope.should_receive(:new).and_return(@stubbed_model)
    do_request
    assigns[@assigns_model_name].should equal(@stubbed_model)
  end
  
  # guess at the request if not present
  def method_missing name, *args
    if name.to_s == 'do_request'
      get :new, build_param_hash
    else
      super
    end
  end
end

describe "CRUD GET edit", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_parent_model_scope
  end
  
  it "should succeed" do
    @finder_scope.stub!(:find)
    do_request
    response.should be_success
  end

  it "should render the 'edit' template" do
    @finder_scope.stub!(:find)
    do_request
    response.should render_template('edit')
  end

  it "should find the requested model" do
    @finder_scope.should_receive(:find).with("1")
    do_request
  end

  it "should assign the found Model for the view" do
    @finder_scope.should_receive(:find).and_return(@stubbed_model)
    do_request
    assigns[@assigns_model_name].should equal(@stubbed_model)
  end
  
  # guess at the request if not present
  def method_missing name, *args
    if name.to_s == 'do_request'
      get :edit, build_param_hash
    else
      super
    end
  end
end

describe "CRUD POST create", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_parent_model_scope
    @finder_scope.stub!(:new).and_return(@stubbed_model)
  end
  
  describe "with successful save" do

    it "should create a new model" do
      @finder_scope.should_receive(:new).with({'these' => 'params'}).and_return(@stubbed_model)
      do_request
    end
    
    it "should attempt to save the model" do
      @stubbed_model.should_receive(:save).and_return(true)
      do_request
    end
    
    # it "should assign the model to the current site" do
    #   @finder_scope.stub!(:new).and_return(@stubbed_model)
    #   @stubbed_model.should_receive(:site=).with(@site).and_return(true)
    #   do_request
    # end

    it "should assign the created model for the view" do
      @finder_scope.stub!(:new).and_return(@stubbed_model)
      do_request
      assigns(@assigns_model_name).should equal(@stubbed_model)
    end
    
  end
  
  describe "with failed save" do
    before(:each) do
      @stubbed_model.stub!(:save).and_return(false)
    end
  
    it "should create a new model" do
      @finder_scope.should_receive(:new).with({'these' => 'params'}).and_return(@stubbed_model)
      do_request
    end
  
    it "should assign the invalid model for the view" do
      @finder_scope.stub!(:new).and_return(@stubbed_model)
      do_request
      assigns(@assigns_model_name).should equal(@stubbed_model)
    end
  
    it "should re-render the 'new' template" do
      @stubbed_model.stub!(:save).and_return(false)
      @finder_scope.stub!(:new).and_return(@stubbed_model)
      do_request
      response.should render_template('new')
    end
    
  end
end

describe "CRUD PUT update", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_parent_model_scope
  end
  
  describe "with successful update" do
    before(:each) do
      @stubbed_model.stub!(:update_attributes).and_return(true)
    end

    it "should find the requested model" do
      @finder_scope.should_receive(:find).with("1").and_return(@stubbed_model)
      do_request
    end

    it "should update the found model" do
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      @stubbed_model.should_receive(:update_attributes).with({'these' => 'params'})
      do_request
    end

    it "should assign the found model for the view" do
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      do_request
      assigns(@assigns_model_name).should equal(@stubbed_model)
    end

  end
  
  describe "with failed update" do
    
    before(:each) do
      @stubbed_model.stub!(:update_attributes).and_return(false)
    end

    it "should find the requested model" do
      @finder_scope.should_receive(:find).with("1").and_return(@stubbed_model)
      do_request
    end

    it "should update the found model" do
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      @stubbed_model.should_receive(:update_attributes).with({'these' => 'params'})
      do_request
    end

    it "should assign the found model for the view" do
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      do_request
      assigns(@assigns_model_name).should equal(@stubbed_model)
    end

    it "should re-render the 'edit' template" do
      @finder_scope.stub!(:find).and_return(@stubbed_model)
      do_request
      response.should render_template('edit')
    end

  end
end

describe "CRUD DELETE destroy", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_parent_model_scope
  end
  
  it "should find the model requested" do
    @finder_scope.should_receive(:find).with("1").and_return(@stubbed_model)
    do_request
  end

  it "should call destroy on the found model" do
    @finder_scope.stub!(:find).and_return(@stubbed_model)
    @stubbed_model.should_receive(:destroy).and_return(true)
    do_request
  end
  
  # guess at the request if not present
  def method_missing name, *args
    if name.to_s == 'do_request'
      delete :destroy, build_param_hash
    else
      super
    end
  end
end