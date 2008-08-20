require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Column do
  before(:each) do
    @valid_attributes = {
      :model_id         => "1",
      :name             => "value for name",
      :column_type      => "value for column_type",
      :default_value    => "value for default_value",
      :appears_in_views => false,
      :column_type      => 'string'
    }
    
    @column = Column.new
  end

  it "should create a new instance given valid attributes" do
    Column.create!(@valid_attributes)
  end
  
  it "should belong to a model" do
    @column.should belong_to(:model)
  end
  
  it "should validate presence of model_id" do
    @column.should validate_presence_of(:model_id)
  end
  
  it "should validate presence of name" do
    @column.should validate_presence_of(:name)
  end
  
  it "should validate presence of column_type" do
    @column.should validate_presence_of(:column_type)
  end
end
