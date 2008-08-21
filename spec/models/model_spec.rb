require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Model do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :site_id => "1"
    }
    @model = Model.new
  end

  it "should create a new instance given valid attributes" do
    Model.create!(@valid_attributes)
  end
  
  it "should have many columns" do
    @model.should have_many(:columns)
  end
  
  it "should have many validations" do
    @model.should have_many(:validations)
  end
  
  it "should have many associations" do
    @model.should have_many(:associations)
  end
  
  it "should validate presence of site_id" do
    @model.should validate_presence_of(:site_id)
  end
  
  it "should validate presence of name" do
    @model.should validate_presence_of(:name)
  end
  
  it "should belong to a site" do
    @model.should belong_to(:site)
  end
end
