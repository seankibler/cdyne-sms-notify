require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'builder'

describe "Response" do
  before(:each) do
    @xml = <<EOXML
<?xml version="1.0" encoding="utf-8"?>
<SmsReturn xmlns="http://ws.cdyne.com/SmsWS/">
  <StatusCode>1</StatusCode>
  <StatusText>Success</StatusText>
  <Completed>1</Completed>
  <TextID>12345678</TextID>
  <Demo>0</Demo>
  <ScheduledTime></ScheduledTime>
  <Responded>0</Responded>
</SmsReturn>
EOXML
  end
  
  after(:each) do
    @xml = ''
  end

  it "should convert an xml response body into a hash" do
    @response_hash = {
      :sms_return => {
        :status_code=>"1",
        :status_text=>"Success",
        :completed=>"1",
        :text_id=>"12345678",
        :demo=>"0",
        :scheduled_time=>nil,
        :responded=>"0",
        :xmlns=>"http://ws.cdyne.com/SmsWS/"
      }
    }
    SmsNotify::Response.parse(@xml).should == @response_hash
  end
end

