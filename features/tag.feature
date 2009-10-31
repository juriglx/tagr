Feature: Manage Tags
    In order to manage files or directories
    As an user
    I want instant access to files without big effort
    
    Scenario: Add Tag
        Given I have a file called "book.pdf" in the testpath
        When I run "tag" "add" "book" "book.pdf" in the testpath
        Then I should have the tag "book" assigned to the path of "book.pdf" in my .tags file 