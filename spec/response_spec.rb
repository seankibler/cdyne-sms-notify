require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'builder'

describe "Response" do
  describe "parse" do
    it "should convert an xml response body into a hash" do
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
      @response_hash = {
        :sms_return => {
          :status_code=>"1",
          :status_text=>"Success",
          :completed=>"1",
          :text_id=>"12345678",
          :demo=>"0",
          :scheduled_time=>nil,
          :responded=>"0",
          :xmlns=>"http://ws.cdyne.com/SmsWS/",
        }
      }
      
      SmsNotify::Response.parse(@xml).should == @response_hash
    end

    it "should convert multiple responses into an array of hashes" do
      @xml = <<EOF
      <?xml version="1.0" encoding="utf-8"?>
<ArrayOfSmsResponse xmlns="http://ws.cdyne.com/SmsWS/">
  <SmsResponse>
    <ResponseID>e3h8a2b</ResponseID>
    <TextID>e3dc20</TextID>
    <StatusCode>5</StatusCode>
    <ReceivedDate></ReceivedDate>
    <Message>Hello</Message>
  </SmsResponse>
  <SmsResponse>
    <ResponseID>h2a0cd8</ResponseID>
    <TextID>c58a9d0</TextID>
    <StatusCode>4</StatusCode>
    <ReceivedDate></ReceivedDate>
    <Message>Hello again</Message>
  </SmsResponse>
</ArrayOfSmsResponse>
EOF
      @response_array = {
        :array_of_sms_response => {
          :xmlns=>"http://ws.cdyne.com/SmsWS/",
          :sms_response => [
            {
              :response_id    => 'e3h8a2b',
              :text_id        => 'e3dc20',
              :status_code    => '5',
              :received_date  => nil,
              :message        => 'Hello'
            },
            {
              :response_id    => 'h2a0cd8',
              :text_id        => 'c58a9d0',
              :status_code    => '4',
              :received_date  => nil,
              :message        => 'Hello again'
            }
          ]
        }
      }
      SmsNotify::Response.parse(@xml).should == @response_array
    end
  end
end

