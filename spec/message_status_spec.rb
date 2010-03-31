require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SmsNotify MessageStatus" do
  before(:each) do
    @message_status = SmsNotify::MessageStatus.new
  end

  it "should have methods for any hash attributes passed in" do
    SmsNotify::MessageStatus.new(:foo => 'bar').foo.should == 'bar'
    SmsNotify::MessageStatus.new(:bolt_action => 'rifle').bolt_action.should == 'rifle'
  end
end

