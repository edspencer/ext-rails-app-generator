require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SitesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "sites", :action => "index").should == "/sites"
    end
  
    it "should map #new" do
      route_for(:controller => "sites", :action => "new").should == "/sites/new"
    end
  
    it "should map #show" do
      route_for(:controller => "sites", :action => "show", :id => 1).should == "/sites/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "sites", :action => "edit", :id => 1).should == "/sites/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "sites", :action => "update", :id => 1).should == "/sites/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "sites", :action => "destroy", :id => 1).should == "/sites/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/sites").should == {:controller => "sites", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/sites/new").should == {:controller => "sites", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/sites").should == {:controller => "sites", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/sites/1").should == {:controller => "sites", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/sites/1/edit").should == {:controller => "sites", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/sites/1").should == {:controller => "sites", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/sites/1").should == {:controller => "sites", :action => "destroy", :id => "1"}
    end
  end
end
