require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Log do  
  it_should_validate_presence_of :site_id, :message
  it_should_be_createable :with => {:site_id => "1",:message => "value for message"}
  
  it_should_belong_to(:site)
end
