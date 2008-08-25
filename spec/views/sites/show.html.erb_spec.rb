require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/show.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:site] = @site = stub_model(Site)
  end

end

