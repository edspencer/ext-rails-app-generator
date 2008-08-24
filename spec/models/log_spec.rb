require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Log do
  before(:each) do
    @valid_attributes = {
      :site_id => "1",
      :message => "value for message"
    }
    
    @log = Log.new
  end

  it "should create a new instance given valid attributes" do
    Log.create!(@valid_attributes)
  end
  
  it "should belong to site" do
    @log.should belong_to(:site)
  end
  
  it "should validate presence of site_id" do
    @log.should validate_presence_of(:site_id)
  end
  
  it "should validate presence of message" do
    @log.should validate_presence_of(:message)
  end
end
