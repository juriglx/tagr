require 'rubygems'
require 'json'

class Tagr
  
  TAGFILE_NAME = ".tags"

  def initialize(working_dir, out)
    @working_dir = working_dir
    @tagfile = File.join(@working_dir, TAGFILE_NAME)
    @out = out
  end
  
  def run(args)
    cmd = args.shift
    case
    when cmd == "add"
      add(*args)
    when cmd == "list"
      list()
    when cmd == "show"
      show(*args)
    end
  end
  
  def add(file, *tag_array)
    return unless File.exist?(File.join(@working_dir, file))
    tags = read_tags()
    tag_array.each { |tag| 
      files = tags[tag]
      if(files.nil?)
        tags[tag] = [file]
      else
        tags[tag].push(file).uniq!
      end
    }
    write_tags(tags)
  end
  
  def list()
    tags = read_tags()
    return if tags.empty?
    ts = tags.sort.inject([]) { | m, (k, v) | m << k + " " + v.length.to_s}
    @out.write(ts.join("\n") + "\n")
  end
  
  def show(*tag_array)
    tags = read_tags()
    file_arrays = []
    tag_array.each { |tag| 
      if (tags.empty? or tags[tag].nil?)
        file_arrays << [] 
      else
        file_arrays << tags[tag]
      end
    }
    fs = file_arrays.inject {|files, file_array| files & file_array }
    @out.write(fs.sort.join(" ") + "\n") 
  end
  
  def exist?(file, tag)
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



