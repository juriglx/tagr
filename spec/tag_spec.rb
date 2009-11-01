require 'spec'

TESTPATH = File.expand_path(File.join(File.dirname(__FILE__), "..", "testpath"))
$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'tagr.rb'

describe "the tagr" do
  before(:each) do
    @cliout = StringIO.new
    @tagr = Tagr.new(TESTPATH, @cliout)
    @tagr.delete_all
  end
  
  it "should add tags to the .tags file" do
    @tagr.run(["add", "mytag", "book.pdf"])
    @tagr.exist?("mytag", "book.pdf").should == true
  end
  
  it "should list all available tags" do
    @tagr.run(["add", "mytag", "book.pdf"])
    @tagr.run(["list"])
    @cliout.string.should include("mytag")
  end
  
  it "should show all files or directories tagged with a tag" do 
    @tagr.run(["add", "mytag", "book.pdf"])
    @tagr.run(["show", "mytag"])
    @cliout.string.should include("book.pdf")
  end
  it "should accept multiple tags for a file or directory on add" do
    pending
  end
  it "should accept multiple tags for a file or directory on show" do
    pending
  end
  it "should not add tag file combinations twice" do
    @tagr.run(["add", "mytag", "book.pdf"])
    @tagr.run(["add", "mytag", "book.pdf"])
    @tagr.run(["show", "mytag"])
    @cliout.string.split(" ").length.should == @cliout.string.split(" ").uniq.length
  end
  it "should not add the tag and file if the tagged file or directory does not exist" do
    @tagr.run(["add", "mytag", "random.file"])
    @tagr.run(["show", "mytag"])
    @cliout.string.should_not include("random.file")
  end
  it "should append on directories a trailing slash" do
    pending
  end
end

describe "the command-line interface" do
  it "should accept the -f option to set the tagfile location" do
    pending
  end
  it "should accept the -r option to recursively tag files" do
    pending
  end
end

describe "the tagfile" do
  it "should have a newline at the end" do
    pending
  end
end