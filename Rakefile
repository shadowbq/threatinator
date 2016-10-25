require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

begin
  require 'jeweler'
rescue LoadError
else
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name = "shadowbq-threatinator"
    gem.homepage = "http://github.com/shadowbq/threatinator"
    gem.license = "LGLv3"
    gem.summary = %Q{Shadowbq-Threatinator is a library and tool for parsing threat data feeds.}
    gem.description = "This is a fork of the cikl/threatinator project"
    gem.email = "shadowbq@gmail.com"
    gem.authors = ["Mike Ryan", "Pierre Lamy", "Scott MacGregor"]
    gem.files  =
      ['bin/threatinator'] +
      Dir.glob("lib/**/*.rb") +
      Dir.glob("spec/**/*") +
      Dir.glob("feeds/**/*.feed") +
      %w(CONTRIBUTING.md CHANGELOG.md LICENSE Gemfile README.md Rakefile VERSION)

  end
  Jeweler::RubygemsDotOrgTasks.new
end

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'
rescue LoadError
else
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
  end
end

task :default => [ :spec ]
