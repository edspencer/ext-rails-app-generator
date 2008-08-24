require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Controller do
  before(:each) do
    @valid_attributes = {
      :model_id => "1",
      :name => "value for name",
      :lft => "1",
      :rgt => "1",
      :parent_id => "1",
      :namespace => "value for namespace",
      :responds_to_html => false,
      :responds_to_xml => false,
      :responds_to_json => false
    }
    
    @controller = Controller.new
  end

  it "should create a new instance given valid attributes" do
    Controller.create!(@valid_attributes)
  end
  
  it "should belong to model" do
    @controller.should belong_to(:model)
  end
  
  it "should validate presence of name" do
    @controller.should validate_presence_of(:name)
  end
end
