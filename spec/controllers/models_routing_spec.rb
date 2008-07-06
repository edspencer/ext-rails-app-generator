require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelsController do
  describe "route generation" do

    it "should map { :controller => 'models', :action => 'index' } to /models" do
      route_for(:controller => "models", :action => "index", :site_id => 1).should == "/sites/1/models"
    end
  
    it "should map { :controller => 'models', :action => 'new' } to /models/new" do
      route_for(:controller => "models", :action => "new", :site_id => 1).should == "/sites/1/models/new"
    end
  
    it "should map { :controller => 'models', :action => 'show', :id => 1 } to /models/1" do
      route_for(:controller => "models", :action => "show", :id => 1, :site_id => 1).should == "/sites/1/models/1"
    end
  
    it "should map { :controller => 'models', :action => 'edit', :id => 1 } to /models/1/edit" do
      route_for(:controller => "models", :action => "edit", :id => 1, :site_id => 1).should == "/sites/1/models/1/edit"
    end
  
    it "should map { :controller => 'models', :action => 'update', :id => 1} to /models/1" do
      route_for(:controller => "models", :action => "update", :id => 1, :site_id => 1).should == "/sites/1/models/1"
    end
  
    it "should map { :controller => 'models', :action => 'destroy', :id => 1} to /models/1" do
      route_for(:controller => "models", :action => "destroy", :id => 1, :site_id => 1).should == "/sites/1/models/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'models', action => 'index' } from GET /models" do
      params_from(:get, "/sites/1/models").should == {:controller => "models", :action => "index", :site_id => "1"}
    end
  
    it "should generate params { :controller => 'models', action => 'new' } from GET /models/new" do
      params_from(:get, "/sites/1/models/new").should == {:controller => "models", :action => "new", :site_id => "1"}
    end
  
    it "should generate params { :controller => 'models', action => 'create' } from POST /models" do
      params_from(:post, "/sites/1/models").should == {:controller => "models", :action => "create", :site_id => "1"}
    end
  
    it "should generate params { :controller => 'models', action => 'show', id => '1' } from GET /models/1" do
      params_from(:get, "/sites/1/models/1").should == {:controller => "models", :action => "show", :id => "1", :site_id => "1"}
    end
  
    it "should generate params { :controller => 'models', action => 'edit', id => '1' } from GET /models/1;edit" do
      params_from(:get, "/sites/1/models/1/edit").should == {:controller => "models", :action => "edit", :id => "1", :site_id => "1"}
    end
  
    it "should generate params { :controller => 'models', action => 'update', id => '1' } from PUT /models/1" do
      params_from(:put, "/sites/1/models/1").should == {:controller => "models", :action => "update", :id => "1", :site_id => "1"}
    end
  
    it "should generate params { :controller => 'models', action => 'destroy', id => '1' } from DELETE /models/1" do
      params_from(:delete, "/sites/1/models/1").should == {:controller => "models", :action => "destroy", :id => "1", :site_id => "1"}
    end
  end
end
