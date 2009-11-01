#!/usr/bin/env ruby

require 'rubygems'
require 'json'

class Tag

  def initialize(working_dir, out)
    @tagfile = File.join(working_dir, ".tags")
    @out = out
  end
  
  def run(arguments)
    case
    when arguments[0] == "add"
      add(arguments[1], arguments[2])
    when arguments[0] == "list"
      list()
    end
  end
  
  def add(tag, file)
    tags = read_tags()
    files = tags[tag]
    if(files.nil?)
      tags[tag] = [file]
    else
      tags[tag].push(file)
    end
    write_tags(tags)
  end
  
  def list()
    tags = read_tags()
    @out.write("") if tags.empty?
    @out.write(tags.keys.sort)
  end
  
  def exist?(tag, file)
    files = read_tags()[tag]
    return false if files.nil?
    return files.include?(file)
  end
  
  private
  def read_tags
    f = nil
    begin
      f = File.open(@tagfile, 'r')      
    rescue Errno::ENOENT
      return {}
    else
      tags = f.read
      return {} if tags.empty?
      return JSON.parse(tags)
    ensure
      f.close unless f.nil?      
    end
  end
  
  def write_tags(tags)
    f = File.open(@tagfile, 'w')
    f.write(JSON.generate(tags))
    f.close unless f.nil?
  end
end

tag = Tag.new(Dir.pwd, STDOUT)
tag.run(ARGV)



