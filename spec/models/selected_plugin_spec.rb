require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SelectedPlugin do
  it_should_be_createable        :with => {:site_id => 1, :plugin_id => 1}
  it_should_validate_presence_of :site_id, :plugin_id
  it_should_belong_to            :site, :plugin

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
