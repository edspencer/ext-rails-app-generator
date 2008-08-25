require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Controller do
  it_should_be_createable        :with => {:name => 'test'}
  it_should_validate_presence_of :name
  it_should_belong_to            :model
end
