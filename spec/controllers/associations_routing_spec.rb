require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AssociationsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "associations", :action => "index", :site_id => 1, :model_id => 1).should == "/sites/1/models/1/associations"
    end
  
    it "should map #new" do
      route_for(:controller => "associations", :action => "new", :site_id => 1, :model_id => 1).should == "/sites/1/models/1/associations/new"
    end
  
    it "should map #show" do
      route_for(:controller => "associations", :action => "show", :id => 1, :site_id => 1, :model_id => 1).should == "/sites/1/models/1/associations/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "associations", :action => "edit", :id => 1, :site_id => 1, :model_id => 1).should == "/sites/1/models/1/associations/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "associations", :action => "update", :id => 1, :site_id => 1, :model_id => 1).should == "/sites/1/models/1/associations/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "associations", :action => "destroy", :id => 1, :site_id => 1, :model_id => 1).should == "/sites/1/models/1/associations/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/sites/1/models/1/associations").should == {:controller => "associations", :action => "index", :site_id => "1", :model_id => "1"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/sites/1/models/1/associations/new").should == {:controller => "associations", :action => "new", :site_id => "1", :model_id => "1"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/sites/1/models/1/associations").should == {:controller => "associations", :action => "create", :site_id => "1", :model_id => "1"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/sites/1/models/1/associations/1").should == {:controller => "associations", :action => "show", :id => "1", :site_id => "1", :model_id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/sites/1/models/1/associations/1/edit").should == {:controller => "associations", :action => "edit", :id => "1", :site_id => "1", :model_id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/sites/1/models/1/associations/1").should == {:controller => "associations", :action => "update", :id => "1", :site_id => "1", :model_id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/sites/1/models/1/associations/1").should == {:controller => "associations", :action => "destroy", :id => "1", :site_id => "1", :model_id => "1"}
    end
  end
end
