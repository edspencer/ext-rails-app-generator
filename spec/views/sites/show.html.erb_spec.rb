require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/show.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:site] = @site = stub_model(Site)
  end

  it "should render attributes in <p>" do
    render "/sites/show.html.erb"
  end
end

