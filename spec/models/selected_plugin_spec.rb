require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SelectedPlugin do
  describe "validations" do
    before(:each) do
      @valid_attributes = {
        :site_id => "1",
        :plugin_id => "1",
        :generator_argument => "value for generator_argument"
      }
    
      @selected_plugin = SelectedPlugin.new
    end

    it "should create a new instance given valid attributes" do
      SelectedPlugin.create!(@valid_attributes)
    end
  
    it "should belong to site" do
      @selected_plugin.should belong_to(:site)
    end
  
    it "should belong to plugin" do
      @selected_plugin.should belong_to(:plugin)
    end
  
    it "should validate presence of site_id" do
      @selected_plugin.should validate_presence_of(:site_id)
    end
  
    it "should validate presence of plugin_id" do
      @selected_plugin.should validate_presence_of(:plugin_id)
    end
  end
  
  describe "the generator argument" do
    before(:each) do
      @plugin = mock_model(Plugin, :default_generator_argument => "default arg", :generator_name => "some_generator")
      @selected_plugin = SelectedPlugin.new(:plugin => @plugin)
    end
    
    it "should use its own generator argument if present" do
      @selected_plugin.generator_argument = "some other arg"
      @selected_plugin.generator_call.should == "ruby script/generate some_generator some other arg"
    end
    
    it "should use the plugin's default argument if not present" do
      @selected_plugin.generator_call.should == "ruby script/generate some_generator default arg"
    end
  end
  
end
