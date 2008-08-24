require File.dirname(__FILE__) + '/../spec_helper'

describe Site do
  before(:each) do
    @site = Site.new(:generation_start_time => 5.minutes.ago, :generation_stop_time => 2.minutes.ago)
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
  
  it "should return the correct generate time" do
    @site.generation_time.should == 3.minutes
  end
  
  it "should return the correct average generation time" do
    create_site 5.minutes.ago, 0.minutes.ago
    create_site 7.minutes.ago, 0.minutes.ago
    create_site 9.minutes.ago, 0.minutes.ago
    
    pending("best way of doing this for SQLite?")
    Site.average_generation_time.should == 7.minutes
  end
  
  private
  def create_site generation_start_time, generation_stop_time
    Site.create!(:user_id => 1, :name => 'Test', :generation_start_time => generation_start_time,
                                                 :generation_stop_time  => generation_stop_time)
  end
end