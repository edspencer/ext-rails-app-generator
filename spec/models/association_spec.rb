require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Association do
  before(:each) do
    @valid_attributes = {
      :model_id => "1",
      :foreign_model_id => "1",
      :association_type => "has_many"
    }
    
    @association = Association.new
  end

  it "should create a new instance given valid attributes" do
    Association.create!(@valid_attributes)
  end
  
  it "should belong to model" do
    @association.should belong_to(:model)
  end
  
  it "should belong to foreign_model" do
    @association.should belong_to(:foreign_model)
  end
  
  it "should validate presence of association_type" do
    @association.should validate_presence_of(:association_type)
  end
  
  describe "the association_type" do
    before(:each) do
      @association = Association.new(:model_id => "1", :foreign_model_id => "2")
    end
    
    #TODO: Write a custom matcher for these
    it "may be has_many" do
      @association.should_not be_valid
      @association.association_type = "has_many"
      @association.should be_valid
    end
    
    it "may be has_one" do
      @association.should_not be_valid
      @association.association_type = "has_one"
      @association.should be_valid
    end
    
    it "may be belongs_to" do
      @association.should_not be_valid
      @association.association_type = "belongs_to"
      @association.should be_valid
    end
    
    it "may be has_and_belongs_to_many" do
      @association.should_not be_valid
      @association.association_type = "has_and_belongs_to_many"
      @association.should be_valid
    end
    
    it "should not be any other value" do
      #FIXME: There must be a better way to do all this
      %w(some other values which are not allowed).each do |bad_value|
        @association.association_type = bad_value
        @association.should_not be_valid
      end
    end
  end
end
