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
        "SmsReturn" => {
          "StatusCode"=>"1",
          "StatusText"=>"Success",
          "Completed"=>"1",
          "TextID"=>"12345678",
          "Demo"=>"0",
          "ScheduledTime"=>nil,
          "Responded"=>"0",
          "xmlns"=>"http://ws.cdyne.com/SmsWS/",
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
        "ArrayOfSmsResponse" => {
          "xmlns"=>"http://ws.cdyne.com/SmsWS/",
          "SmsResponse" => [
            {
              "ResponseID"    => 'e3h8a2b',
              "TextID"        => 'e3dc20',
              "StatusCode"    => '5',
              "ReceivedDate"  => nil,
              "Message"        => 'Hello'
            },
            {
              "ResponseID"    => 'h2a0cd8',
              "TextID"        => 'c58a9d0',
              "StatusCode"    => '4',
              "ReceivedDate"  => nil,
              "Message"        => 'Hello again'
            }
          ]
        }
      }
      SmsNotify::Response.parse(@xml).should == @response_array
    end
  end
end

