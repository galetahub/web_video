# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "web_video/version"

Gem::Specification.new do |s|
  s.name = "web_video"
  s.version = WebVideo::VERSION.dup
  s.platform = Gem::Platform::RUBY 
  s.summary = "WebVideo allows you to inspect and process video files"
  s.description = "WebVideo allows you to inspect, convert and take screenshots from video files"
  s.authors = ["Igor Galeta"]
  s.email = "galeta.igor@gmail.com"
  s.rubyforge_project = "web_video"
  s.homepage = "http://github.com/galetahub/web_video"
  
  s.files = Dir["{app,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["{test}/**/*"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.require_paths = ["lib"]

  s.add_dependency("subexec", ">= 0")
  s.add_dependency("activesupport", ">= 0")
end
