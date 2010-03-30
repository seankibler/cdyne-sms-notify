# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SmsNotify do
  it "should create a module to nest other classes under" do
    SmsNotify.should be_a Module
  end

  it "should create a connection error class" do
    SmsNotify::ConnectionError.should be_a Class
  end

  it "should create an api error class" do
    SmsNotify::ApiError.should be_a Class
  end
end

