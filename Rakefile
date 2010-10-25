require 'rubygems'
require 'rcov/rcovtask'
require "rspec"
require "rspec/core/rake_task"
require File.join(File.dirname(__FILE__), *%w[lib sms_notify version])

begin
	require 'jeweler'

	Jeweler::Tasks.new do |gemspec|
		gemspec.name              = "cdyne-sms-notify"
    gemspec.summary           = "Ruby interface to the CDYNE SMSNotify! service."
    gemspec.email             = "gems@skiblerspot.net"
    gemspec.rubyforge_project = 'cdyne-sms-notify'
    gemspec.homepage          = "http://github.com/badreligion/cdyne-sms-notify"
    gemspec.authors           = ["Sean Kibler"]
    gemspec.extra_rdoc_files  = %w{History.txt License.txt README.rdoc}
    gemspec.has_rdoc          = true
    gemspec.version           = SmsNotify::Version
	end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
	puts "Jeweler not found, it can be installed with the following command:\n\ngem install jeweler"
end

task :default => :spec

Rspec::Core::RakeTask.new('rcov') do |t|
  t.pattern = 'spec/**/*_spec.rb'
	t.rcov    = true
end

task :doc do
	system("rdoc")
end
