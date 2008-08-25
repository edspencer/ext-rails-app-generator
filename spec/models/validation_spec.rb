require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Validation do

  it_should_be_createable :with => {:column_id => "1", :validation_type => "validates_presence_of"}
  it_should_belong_to :column
  it_should_validate_presence_of :column_id
  
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
