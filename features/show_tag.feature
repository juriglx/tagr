Feature: Show Tags
    In order to manage files or directories
    As an user
    I want to show all files tagged with a tag
    
    Scenario: Show Tags
        Given I have the tag "sweetness" in my .tags file attached to "book.pdf"
        When I run tagr.rb "show sweetness" in the testpath
        And I should see "book.pdf"