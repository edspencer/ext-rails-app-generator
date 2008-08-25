require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Column do
  it_should_be_createable        :with => {:model_id => 1, :name => 'test', :column_type => 'string'}
  it_should_validate_presence_of :model_id, :name, :column_type
  it_should_belong_to            :model
end
