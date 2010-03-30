# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SmsNotify MessageStatus" do
  before(:each) do
    @message_status = SmsNotify::MessageStatus.new
  end

  it "should contain attributes that describe an SmsNotify! message" do
    api_attrs = [:status_code, :status_text, :completed, :text_id, :demo, :scheduled_time, :responded]
    SmsNotify::MessageStatus.new.should == api_attrs
  end
end

