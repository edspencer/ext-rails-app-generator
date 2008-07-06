require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/models/edit.html.erb" do
  include ModelsHelper
  
  before(:each) do
    assigns[:model] = @model = stub_model(Model,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "should render edit form" do
    render "/models/edit.html.erb"
    
    response.should have_tag("form[action=#{model_path(@model)}][method=post]") do
      with_tag('input#model_name[name=?]', "model[name]")
    end
  end
end


