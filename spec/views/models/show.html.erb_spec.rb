require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/models/show.html.erb" do
  include ModelsHelper
  
  before(:each) do
    assigns[:model] = @model = stub_model(Model,
      :name => "value for name"
    )
  end

  it "should render attributes in <p>" do
    render "/models/show.html.erb"
    response.should have_text(/value\ for\ name/)
  end
end

