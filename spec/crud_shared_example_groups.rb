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
    @stubbed_model = mock(@model_name, :id => 1, :to_xml => 'XML', :mock_object => true)
    @stubbed_model_collection = [@stubbed_model]
    @model_klass.stub!(:find).with(:all).and_return(@stubbed_model_collection)
    
    # e.g. Asset.stub!(:count).and_return(@count)
    @count = 10
    @model_klass.stub!(:count).and_return(@count)
  end
end

describe "CRUD GET index", :shared => true do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  it "should find all #{@pluralized_model_name}" do
    @model_klass.should_receive(:find).with(:all)
    do_request
  end
  
  it "should be successful" do
    do_request
    response.should be_success
  end
  
  it "should render the correct template" do
    do_request
    response.should render_template(:index)
  end
  
  it "should assign the #{@pluralized_model_name} to the #{@pluralized_model_name} view variable" do
    do_request
    assigns[@pluralized_assigns_model_name].should == @stubbed_model_collection
  end
  
  it "should render the correct xml" do
    @stubbed_model_collection.should_receive(:to_xml).and_return('XML')
    do_request nil, 'xml'
    response.body.should == 'XML'
  end

end