require 'rubygems'
require 'json'

class Tagr
  
  TAGFILE_NAME = ".tags"

  def initialize(working_dir, out)
    @working_dir = working_dir
    @tagfile = File.join(@working_dir, TAGFILE_NAME)
    @out = out
  end
  
  def run(arguments)
    cmd = arguments[0]
    case
    when cmd == "add"
      add(arguments[1], arguments[2])
    when cmd == "list"
      list()
    when cmd == "show"
      show(arguments[1])
    end
  end
  
  def add(tag, file)
    return unless File.exist?(File.join(@working_dir, file))
    tags = read_tags()
    files = tags[tag]
    if(files.nil?)
      tags[tag] = [file]
    else
      tags[tag].push(file).uniq!
    end
    write_tags(tags)
  end
  
  def list()
    tags = read_tags()
    return if tags.empty?
    @out.write(tags.keys.sort.join(" ") + "\n")
  end
  
  def show(tag)
    tags = read_tags()
    return if (tags.empty? or tags[tag].nil?)
    @out.write(tags[tag].sort.join(" ") + "\n") 
  end
  
  def exist?(tag, file)
    files = read_tags()[tag]
    return false if files.nil?
    return files.include?(file)
  end
  
  def delete_all()
    begin
      File.delete(@tagfile)      
    rescue Errno::ENOENT
    end
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
    f.write(JSON.generate(tags) + "\n")
    f.close unless f.nil?
  end
end



