require File.dirname(__FILE__) + '/../spec_helper'

describe Site do
  before(:each) do
    @site = Site.new
  end
  
  it "should validate presence of user_id" do
    @site.should validate_presence_of(:user_id)
  end
  
  it "should validate presence of name" do
    @site.should validate_presence_of(:name)
  end
  
  it "should belong to a user" do
    @site.should belong_to(:user)
  end
end