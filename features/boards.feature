@Some
Feature: C-R-U-D for Boards
    @Some2
    Scenario: Test 1
        Given Defines "GET" request to "/members/me/boards"
        When The request is sent
        #And The schema is validated with "schema.json"
        Then The status code should be 200
