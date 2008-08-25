require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Plugin do
  it_should_be_createable          :with => {:name => 'test', :remote_url => 'test', :local_path => 'test'}
  it_should_validate_presence_of   :remote_url, :local_path, :name
  it_should_validate_uniqueness_of :remote_url, :local_path, :name
  
  it "should not be selected by default unless specified" do
    Plugin.new.selected_by_default.should == false
  end
    
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

end
