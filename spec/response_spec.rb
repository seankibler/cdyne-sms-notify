require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'builder'

describe "Response" do
  before(:each) do
    @response_body = ''

    xml_builder = Builder::XmlMarkup.new(@response_body, :indent => 2)
    xml_builder.instruct!
    xml_builder.SmsReturn(:xmlns => 'http://ws.cdyne.com/SmsWS/') do |sms_return|
      sms_return.StatusCode('0')
      sms_return.StatusText('Success')
      sms_return.Completed('1')
      sms_return.TextID('12345678')
      sms_return.Demo('0')
      sms_return.ScheduledTime('')
      sms_return.Responded('0')
    end
  end

  it "should convert an xml response body into a hash" do
  
  end
end

