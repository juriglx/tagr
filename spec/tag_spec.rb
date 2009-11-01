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
    @tagr.run(["add", "book.pdf", "mytag"])
    @tagr.exist?("book.pdf", "mytag").should == true
  end
  
  it "should list all available tags" do
    @tagr.run(["add", "book.pdf", "mytag"])
    @tagr.run(["list"])
    @cliout.string.should include("mytag")
  end
  
  it "should show all files or directories tagged with a tag" do 
    @tagr.run(["add", "book.pdf", "mytag"])
    @tagr.run(["show", "mytag"])
    @cliout.string.should include("book.pdf")
  end
  
  it "should not add tag file combinations twice" do
    @tagr.run(["add", "book.pdf", "mytag"])
    @tagr.run(["add", "book.pdf", "mytag"])
    @tagr.run(["show", "mytag"])
    @cliout.string.split(" ").length.should == @cliout.string.split(" ").uniq.length
  end
  
  it "should not add the tag and file if the tagged file or directory does not exist" do
    @tagr.run(["add", "random.file", "mytag"])
    @tagr.run(["show", "mytag"])
    @cliout.string.should_not include("random.file")
  end
  
  it "should accept multiple tags for a file or directory on add" do
    @tagr.run(["add", "book.pdf", "tag_one", "tag_two"])
    @tagr.run(["list"])
    @cliout.string.should include("tag_one")
    @cliout.string.should include("tag_two")
  end
  
  it "should accept multiple tags for a file or directory on show" do
    @tagr.run(["add", "book.pdf", "tag_one", "tag_two"])
    @tagr.run(["add", "book.txt", "tag_one"])
    @tagr.run(["show", "tag_one", "tag_two"])
    @cliout.string.should include("book.pdf")
    @cliout.string.should_not include("book.txt")
  end
  
  it "should show the number of files tagged with a tag" do
    @tagr.run(["add", "book.pdf", "tag_one"])
    @tagr.run(["add", "book.txt", "tag_one"])
    @tagr.run(["list"])
    @cliout.string.should include("tag_one")
    @cliout.string.should include("2")
  end

  it "should append on directories a trailing slash" do
    pending
  end
  
  it "should only accept files or directories in subdirectories" do
    pending
  end
  
  it "should accept a regular expression as file argument" do
    pending
  end
  
end

describe "the command-line interface" do
  
  it "should recognize the -f option to set the tagfile location" do
    pending
  end
  
  it "should recognize the -r option to recursively tag files" do
    pending
  end
  
  it "should print a help if the -help option is set" do
    pending
  end
  
  it "should print a help if no cmd match" do
    pending
  end

end

describe "the tagfile" do
  
  it "should have a newline at the end" do
    @tagr = Tagr.new(TESTPATH, StringIO.new)
    @tagr.delete_all
    @tagr.run(["add", "book.pdf", "mytag"])
    File.open(File.join(TESTPATH, Tagr::TAGFILE_NAME)).read.match(/\n$/).should_not == nil
  end

end