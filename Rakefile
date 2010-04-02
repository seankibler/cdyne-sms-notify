require 'rubygems'
require 'rcov/rcovtask'
require "spec"
require "spec/rake/spectask"
require File.join(File.dirname(__FILE__), *%w[lib sms_notify version])

begin
	require 'jeweler'

	Jeweler::Tasks.new do |gemspec|
		gemspec.name = "cdyne-sms-notify"
    gemspec.summary = "Ruby interface to the CDYNE SMSNotify! service."
    gemspec.email = "github@skiblerspot.net"
    gemspec.homepage = "http://cdyne-sms-notify.github.com"
    gemspec.authors = ["Sean Kibler"]
    gemspec.extra_rdoc_files = %w{History.txt License.txt}
    gemspec.has_rdoc = true
    gemspec.version = SmsNotify::Version
	end
rescue LoadError
	puts "Jeweler not found, it can be installed with the following command:\n\ngem install jeweler"
end

task :default => :spec

Spec::Rake::SpecTask.new('run_tests_with_rcov') do |t|
	t.spec_files = FileList['spec/**/*.rb']
	t.rcov = true
	#t.rcov_opts = ['--exclude', '']
end

task :doc do
	system("rdoc -aN")
end
