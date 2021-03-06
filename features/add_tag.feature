Feature: Add Tags
    In order to manage files or directories
    As an user
    I want to tag files
    
    Scenario: Add Tag to not existing tagfile
        Given I have a file called "book.pdf" in the testpath
        And I have no .tags file in the testpath
        When I run tagr.rb "add book.pdf sweetness" in the testpath
        And I should have the tag "sweetness" in my .tags attached to "book.pdf"
        
    Scenario: Add a tag to a file with an existing tag attached to this file 
        Given I have a file called "book.pdf" in the testpath
        And I have the tag "sweetness" in my .tags file attached to "book.pdf"
        When I run tagr.rb "add book.pdf awesome" in the testpath
        Then I should have the tag "sweetness" in my .tags attached to "book.pdf"
        And I should have the tag "awesome" in my .tags attached to "book.pdf"
        
    Scenario: Add a tag to a file with a file is attached to this tag
        Given I have a file called "book.pdf" in the testpath
        And I have a file called "book.txt" in the testpath
        And I have the tag "sweetness" in my .tags file attached to "book.pdf"
        When I run tagr.rb "add book.txt sweetness" in the testpath
        Then I should have the tag "sweetness" in my .tags attached to "book.txt"
        And I should have the tag "sweetness" in my .tags attached to "book.pdf"        
