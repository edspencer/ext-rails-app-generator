require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Model do
  it_should_validate_presence_of :site_id, :name
  it_should_be_createable :with => {:name => 'some name', :site_id => "1"}
  
  it_should_have_many :columns, :validations, :associations, :controllers
  it_should_belong_to :site  
end
