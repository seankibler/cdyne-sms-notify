require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SmsNotify MessageStatus" do
  it "should not have attributes that do not describe a message status" do
    SmsNotify::MessageStatus.new({:Foo=>'bar'}).respond_to?('foo').should be false
  end

  it "should have attributes that describe a message status" do
    SmsNotify::MessageStatus.new({:StatusCode=>'6'}).status_code.should == '6'
  end

  describe "fatal_error?" do
    it "should return true when the status_code describes a message that will not be delivered" do
      status = SmsNotify::MessageStatus.new({:StatusCode=>'3'})
      status.fatal_error?.should be true
    end

    it "should return false when the status_code describes a message that will be delivered" do
      status = SmsNotify::MessageStatus.new({:StatusCode=>'5'})
      status.fatal_error?.should be false
    end
  end
end

