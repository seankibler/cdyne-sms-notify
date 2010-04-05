require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SmsNotify::MessageResponse" do
  it "should return a new instance with empty attributes when initialized" do
    r = SmsNotify::MessageResponse.new({})
    r.response_id.should == nil
    r.text_id.should == nil
    r.message.should == nil
  end

  it "should only contain attributes that describe a message response" do
    attrs = {:xmlns => 'foo', :status_code => '1'}
    r = SmsNotify::MessageResponse.new(attrs)
    r.respond_to?('xmlns').should be false
    r.status_code.should == '1'
  end
end

