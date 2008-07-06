require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/models/index.html.erb" do
  include ModelsHelper
  
  before(:each) do
    assigns[:models] = [
      stub_model(Model,
        :name => "value for name"
      ),
      stub_model(Model,
        :name => "value for name"
      )
    ]
  end

  it "should render list of models" do
    render "/models/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
  end
end

