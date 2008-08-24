require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Git do
  
  # TODO: problems here - clearing the registered SCMs elsewhere in the spec suite affects
  # this spec too as they remain cleared.  Curses
  # it "should register itself with Scm" do
  #   obj = Scm.new_scm('git')
  #   obj.class.to_s.should == 'Git'
  # end
end