require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/index.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:sites] = [
      stub_model(Site),
      stub_model(Site)
    ]
  end

  it "should render list of sites" do
    render "/sites/index.html.erb"
  end
end

