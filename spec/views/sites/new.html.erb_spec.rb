require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/new.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:site] = stub_model(Site,
      :new_record? => true
    )
  end

end


