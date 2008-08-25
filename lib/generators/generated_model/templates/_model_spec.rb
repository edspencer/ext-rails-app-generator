require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe <%= class_name %> do
  it_should_validate_presence_of :model_id, :name, :column_type
  it_should_belong_to            :model
  it_should_have_many            :validations
end
