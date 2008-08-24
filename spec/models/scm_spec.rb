require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

#create a fake container Scm subclass
class MyScm < Scm
  
end

describe Scm do
  before(:each) do
    Scm.clear_registered_scms
  end
  
  it "should allow an SCM subclass to be registered for a particular key" do
    Scm.registered_scms.size.should == 0
    Scm.register_scm(MyScm, 'my_scm')
    
    Scm.registered_scms.size.should == 1
  end
  
  it "should return an instantiation of the correct SCM subclass" do
    Scm.register_scm(MyScm, 'my_scm')
    
    obj = Scm.new_scm('my_scm')
    obj.class.to_s.should == 'MyScm'
  end
  
  it "should clear all registered scms" do
    Scm.register_scm(MyScm, 'my_scm')
    Scm.registered_scms.size.should == 1
    
    Scm.clear_registered_scms
    Scm.registered_scms.size.should == 0
  end
end