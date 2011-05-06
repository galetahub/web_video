require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'web_video', 'version')

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the web_video plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the web_video plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'WebVideo'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "web_video"
    gemspec.version = WebVideo::VERSION.dup
    gemspec.summary = "WebVideo allows you to inspect and process video files"
    gemspec.description = "WebVideo allows you to inspect, convert and take screenshots from video files"
    gemspec.email = "galeta.igor@gmail.com"
    gemspec.homepage = "http://github.com/galetahub/web_video"
    gemspec.authors = ["Igor Galeta"]
    gemspec.files = FileList["[A-Z]*", "{lib, test}/**/*"]
    gemspec.rubyforge_project = "web_video"
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
