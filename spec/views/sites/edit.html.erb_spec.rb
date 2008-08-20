require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sites/edit.html.erb" do
  include SitesHelper
  
  before(:each) do
    assigns[:site] = @site = stub_model(Site,
      :new_record? => false
    )
  end

end


