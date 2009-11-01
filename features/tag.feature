Feature: Manage Tags
    In order to manage files or directories
    As an user
    I want instant access to files without big effort
    
    Scenario: Add Tag
        Given I have a file called "book.pdf" in the testpath
        And I have no .tags file in the testpath
        When I run "tag.rb" "add" "sweetness" "book.pdf" in the testpath
        Then the tag script should be run
        And I should have a .tags file in the testpath
        And I should have the tag "sweetness" in my .tags file
        And I should have the relative path of "book.pdf" in my .tags file
        
    Scenario: Add Tag with existing Tag in Tagfile
        Given I have a file called "book.pdf" in the testpath
        And I have the tag "sweetness" in my .tags file
        When I run "tag.rb" "add" "awesome" "book.pdf" in the testpath
        Then the tag script should be run
        And I should have a .tags file in the testpath
        And I should have the tag "awesome" in my .tags file
        And I should have the tag "sweetness" in my .tags file
        And I should have the relative path of "book.pdf" in my .tags file
        
    Scenario: Add Tag to File with existing Tag
        Given I have a file called "book.pdf" in the testpath
        And I have the tag "sweetness" in my .tags file attached to "book.pdf"
        When I run "tag.rb" "add" "awesome" "book.pdf" in the testpath
        Then I should have the tag "sweetness" in my .tags attached to "book.pdf"
        And I should have the tag "awesome" in my .tags attached to "book.pdf"
        
    # Scenario: Add Tag to File with existing Tag
    #     Given I have a file called "book.pdf" in the testpath
    #     And I have a file called "book.txt" in the testpath
    #     And I have the tag "sweetness" in my .tags file attached to "book.pdf"
    #     When I run "tag.rb" "add" "sweetness" "book.txt" in the testpath
    #     Then I should have the tag "sweetness" in my .tags attached to "book.txt"
    #     And I should have the tag "sweetness" in my .tags attached to "book.pdf"        
        
        
        
    # Scenario: List Tags
    #     Given I have a .tags file in the testpath
    #     And I have the tag "book" in my .tags file
    #     When I run "tag.rb" "list" in the testpath
    #     Then I should see "book"