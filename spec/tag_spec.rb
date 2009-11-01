require 'spec'

TESTPATH = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "testpath"))
$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'tag.rb'

describe "the tagger" do
  it "should add tags to the .tags file" do
    tagger = Tag.new(TESTPATH)
    tagger.add("tag", "file")
    tagger.file
  end
end