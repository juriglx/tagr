require 'rake'
require 'spec/rake/spectask'

task :default => :spec

desc "Run specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  t.spec_files = FileList['spec/*_spec.rb']
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "tagr"
    gemspec.summary = "A command-line tagging tool."
    gemspec.homepage = "http://github.com/juriglx/tagr"
    gemspec.add_dependency('json')
    gemspec.executables << "tagr"
    gemspec.authors = ["Juri Glaß"]
    gemspec.email = "juriglx@googlemail.com"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
