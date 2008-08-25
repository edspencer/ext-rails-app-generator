require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Association do
  it_should_be_createable         :with => {:model_id => 1, :foreign_model_id => 1, :association_type => 'has_many'}
  
  it_should_validate_presence_of  :model_id, :foreign_model_id, :association_type
  it_should_validate_inclusion_of :association_type, :in => %w(has_many has_one belongs_to has_and_belongs_to_many)
  
  it_should_belong_to :model, :foreign_model
end
