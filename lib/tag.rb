#!/usr/bin/env ruby

require 'rubygems'
require 'json'

class Tag

  def initialize(arguments)
    @arguments = arguments
    @tagfile = File.new(File.join(Dir.pwd, ".tags"), 'w')
  end
  
  def run
    tags = {@arguments[1] => @arguments[2]}
    json = JSON.generate(tags)
    @tagfile.write(json)
  end
  
end

tag = Tag.new(ARGV)
tag.run



