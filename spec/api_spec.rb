require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module SmsNotify
	class Api
		class Command
			def execute(parameters)
			end
		end
	end
end

module SmsNotify
  describe "Api" do
    before(:each) do
      @api = Api.new('key')
    end

    it "should return a default endpoint url" do
      Api.endpoint_host.should be_a String
    end

    it "should have a license key method after initialized" do
      @api.license_key.should == 'key'
    end

    it "should respond to send_message" do
      @api.respond_to?('send_message').should be true
    end
		
		describe "message_responses" do
			it "should return an array of MessageResponse objects" do
				@api.message_responses('1234')
			end
		end	

    describe "Api Command" do
      before(:each) do
        @command = Api::Command.new('cmdname', 'key')
      end
    
      it "should return an encoded url for the requested command and parameters" do
        url = @command.build_url(:fu => 'bar', :sna => 'fu')
        url.should == URI.parse('https://ws.cdyne.com/SmsWs/SMS.asmx/cmdname?LicenseKey=key&fu=bar&sna=fu')
      end

      it "should return an encoded url with invalid url characters escaped" do
        url = @command.build_url(:fu => 'b a r', :sna => 'f&u')
        url.should == URI.parse('https://ws.cdyne.com/SmsWs/SMS.asmx/cmdname?LicenseKey=key&fu=b+a+r&sna=f%26u')
      end
    end
  end
end
