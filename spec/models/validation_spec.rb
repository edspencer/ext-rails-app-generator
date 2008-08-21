require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Validation do
  before(:each) do
    @valid_attributes = {
      :column_id => "1",
      :validation_type => "validates_presence_of"
    }
    
    @validation = Validation.new
  end

  it "should create a new instance given valid attributes" do
    Validation.create!(@valid_attributes)
  end
  
  it "should belong to column" do
    @validation.should belong_to(:column)
  end
  
  it "should validate presence of column_id" do
    @validation.should validate_presence_of(:column_id)
  end
  
  describe "the validation_type" do
    before(:each) do
      @validation = Validation.new(:column_id => "1")
    end
    
    #TODO: Write a custom matcher for these
    it "may be validates_presence_of" do
      @validation.should_not be_valid
      @validation.validation_type = "validates_presence_of"
      @validation.should be_valid
    end
    
    it "may be validates_confirmation_of" do
      @validation.should_not be_valid
      @validation.validation_type = "validates_confirmation_of"
      @validation.should be_valid
    end
    
    it "may be validates_acceptance_of" do
      @validation.should_not be_valid
      @validation.validation_type = "validates_acceptance_of"
      @validation.should be_valid
    end
    
    it "may be validates_numericality_of" do
      @validation.should_not be_valid
      @validation.validation_type = "validates_numericality_of"
      @validation.should be_valid
    end
    
    it "may be validates_uniqueness_of" do
      @validation.should_not be_valid
      @validation.validation_type = "validates_uniqueness_of"
      @validation.should be_valid
    end
    
    it "should not be any other value" do
      #FIXME: There must be a better way to do all this
      %w(some other values which are not allowed).each do |bad_value|
        @validation.validation_type = bad_value
        @validation.should_not be_valid
      end
    end
  end
end
