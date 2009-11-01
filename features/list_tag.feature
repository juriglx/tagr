Feature: List Tags
    In order to manage files or directories
    As an user
    I want to list all existing tags
    
    Scenario: List Tags
        Given I have the tag "sweetness" in my .tags file attached to "book.pdf"
        When I run tagr.rb "list" in the testpath
        And I should see "sweetness"