TESTPATH = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "testpath"))

require 'json'
require File.join(File.dirname(__FILE__), "..", "..", "lib", "tag.rb")

Given /^I have a file called "([^\"]*)" in the testpath$/ do |file|
  File.new(File.join(TESTPATH, file), 'w')
end

Given /^I have no \.tags file in the testpath$/ do
  File.delete(File.join(TESTPATH, ".tags"))
end

Given /^I have a \.tags file in the testpath$/ do
  @f = File.new(File.join(TESTPATH, ".tags"), 'w')
end

Given /^I have the tag "([^\"]*)" in my \.tags file$/ do |tag|
  Given "I have a .tags file in the testpath"
  Given "I have the tag \"" + tag + "\" in my .tags file attached to \"my.file\""
end

Given /^I have the tag "([^\"]*)" in my \.tags file attached to "([^\"]*)"$/ do |tag, file|
  Given "I have a .tags file in the testpath"
  tagger = Tag.new(TESTPATH)
  tagger.add(tag, file)
end

When /^I run "([^\"]*)" "([^\"]*)" "([^\"]*)" "([^\"]*)" in the testpath$/ do |cmd, method, arg1, arg2|
  Dir.chdir(TESTPATH)
  @run = system(File.join(TESTPATH, "..", "lib", cmd), method, arg1, arg2)
end

When /^I run "([^\"]*)" "([^\"]*)" in the testpath$/ do |cmd, method|
  pending
end

Then /^the tag script should be run$/ do
  @run.should == true
end

Then /^I should have a \.tags file in the testpath$/ do
  f = File.new(File.join(TESTPATH, ".tags"))
  File.file?(f).should == true
end

Then /^I should have the tag "([^\"]*)" in my \.tags file$/ do |tag|
  tf = File.new(File.join(TESTPATH, ".tags"))
  tf.read.should include(tag)
end

Then /^I should have the relative path of "([^\"]*)" in my \.tags file$/ do |file|
  tf = File.new(File.join(TESTPATH, ".tags"))
  tf.read.should include(file)
end

Then /^I should have the tag "([^\"]*)" in my \.tags attached to "([^\"]*)"$/ do |tag, file|
  Then "I should have a .tags file in the testpath"
  Then "I should have the tag \"" + tag + "\" in my .tags file"
  Then "I should have the relative path of \"" + file + "\" in my .tags file"
  tagger = Tag.new(TESTPATH)
  tagger.exist?(tag, file).should == true
end

Then /^I should see "([^\"]*)"$/ do |arg1|
  pending
end
