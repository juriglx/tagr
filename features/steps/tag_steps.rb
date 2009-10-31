TESTPATH = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "testpath"))

Given /^I have a file called "([^\"]*)" in the testpath$/ do |file|
  File.new(File.join(TESTPATH, file), 'w')
end

When /^I run "([^\"]*)" "([^\"]*)" "([^\"]*)" "([^\"]*)" in the testpath$/ do |cmd, method, arg1, arg2|
  pending
end

Then /^I should have the tag "([^\"]*)" assigned to the path of "([^\"]*)" in my .tags file$/ do |tag, file, tagfile|
  pending
end