require File.dirname(__FILE__) + '/../spec_helper'

describe Site do
  before(:each) do
    @site = Site.new(:generation_start_time => 5.minutes.ago, :generation_stop_time => 2.minutes.ago)
  end
  
  it_should_be_createable :with => {:user_id => 1, :name => 'test'}
  it_should_validate_presence_of :user_id, :name
  it_should_belong_to :user
  it_should_have_many :models, :controllers, :logs
  
  it "should return the correct generate time" do
    @site.generation_time.should == 3.minutes
  end
  
  it "should give an underscored name" do
    @site.name = "Ed's site"
    @site.underscored_name.should == 'Eds_site'
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

describe Site, "when generating" do
  before(:each) do
    @site = Site.new(:rails_version => 'edge')
  end
  
  # it "should have an scm object" do
  #   @site.scm = 'git'
  #   
  #   @site.scm_object.should_not be(nil)
  #   @site.scm_object.class.to_s.should == 'Git'
  # end
  
  it "should return the correct rails generate path" do
    @site.rails_generate_path.should == 'vendor/rails_versions/edge/railties/bin/rails'
  end
end