require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/models/new.html.erb" do
  include ModelsHelper
  
  before(:each) do
    assigns[:model] = stub_model(Model,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "should render new form" do
    render "/models/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", models_path) do
      with_tag("input#model_name[name=?]", "model[name]")
    end
  end
end


