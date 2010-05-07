# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{web_video}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Igor Galeta"]
  s.date = %q{2010-05-07}
  s.description = %q{WebVideo allows you to inspect, convert and take screenshots from video files}
  s.email = %q{galeta.igor@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "lib/web_video.rb",
     "lib/web_video/adapters/abstract_adapter.rb",
     "lib/web_video/adapters/ffmpeg_adapter.rb",
     "lib/web_video/stream.rb",
     "lib/web_video/tools.rb",
     "lib/web_video/transcoder.rb"
  ]
  s.homepage = %q{http://github.com/galetahub/web_video}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{web_video}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{WebVideo allows you to inspect and process video files}
  s.test_files = [
    "test/web_video_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

