require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Plugin do
  
  describe "when deciding whether a generate call is required" do
    before(:each) do
      @plugin = Plugin.new
    end
    
    describe "and one is" do
      before(:each) do
        @plugin.generator_name = 'rspec_model'
      end
      
      it "should return true to generator_call_required?" do
        @plugin.generator_call_required?.should be(true)
      end
    end
    
    describe "and one is not" do
      it "should return false to generator_call_required?" do
        @plugin.generator_call_required?.should be(false)
      end
    end
  end
  
  describe "validations" do
    before(:each) do
      @valid_attributes = {
        :name                       => "name",
        :remote_url                 => "value for remote_url",
        :local_path                 => "value for local_path",
        :generator_name             => "value for generator_name",
        :default_generator_argument => "value for default_generator_argument"
      }
    
      @plugin = Plugin.new
    end

    it "should create a new instance given valid attributes" do
      Plugin.create!(@valid_attributes)
    end
  
    it "should validate presence of remote_url" do
      @plugin.should validate_presence_of(:remote_url)
    end
  
    it "should validate presence of local_path" do
      @plugin.should validate_presence_of(:local_path)
    end
  
    it "should validate presence of name" do
      @plugin.should validate_presence_of(:name)
    end
  
    it "should not be selected by default unless specified" do
      @plugin.selected_by_default.should == false
    end
  
    it "should validate uniqueness of remote_url" do
      @plugin.should validate_uniqueness_of(:remote_url)
    end
  
    it "should validate uniqueness of local_path" do
      @plugin.should validate_uniqueness_of(:local_path)
    end
  
    it "should validate uniqueness of name" do
      @plugin.should validate_uniqueness_of(:name)
    end
  end
end
