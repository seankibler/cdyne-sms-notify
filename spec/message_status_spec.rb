require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SmsNotify MessageStatus" do
  it "should not have attributes that do not describe a message status" do
    SmsNotify::MessageStatus.new({:foo=>'bar'}).respond_to?('foo').should be false
  end

  it "should have attributes that describe a message status" do
    SmsNotify::MessageStatus.new({:status_code=>'6'}).status_code.should == '6'
  end
end

