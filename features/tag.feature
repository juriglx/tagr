Feature: Manage Tags
    In order to manage files or directories
    As an user
    I want instant access to files without big effort
    
    Scenario: Add Tag
        Given I have a file called "book.pdf" in the testpath
        When I run "tag.rb" "add" "book" "book.pdf" in the testpath
        Then the tag script should be run
        And I should have a .tags file in the testpath
        And I should have the tag "book" in my .tags file
        And I should have the relative path of "book.pdf" in my .tags file
        
    # Scenario: List Tags
    #     Given I have a .tags file in the testpath
    #     And I have the tag "book" in my .tags file
    #     When I run "tag.rb" "list" in the testpath
    #     Then I should see "book"