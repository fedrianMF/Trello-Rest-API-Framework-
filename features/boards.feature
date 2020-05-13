@crud
Feature: C-R-U-D for Boards
    @get
    Scenario Outline: Get boards
        Given Defines "GET" request to "/boards/<id>"
        When The request is sent
        #And The schema is validated with "schema.json"
        Then The status code should be 200

        Examples: Data ids
        | id       |
        | yfbg7MMI |
        | 4LmtdO4W |

    @post
    Scenario: Create a board
        Given Defines "POST" request to "/boards/"
        When The new board name is Board Gherkin
        And The request with body is sent
        Then The status code should be 200

    @update
    Scenario: Update a board
        Given Defines "PUT" request to "/boards/4LmtdO4W"
        When The new board name is New Name Board
        And The request with body is sent
        Then The status code should be 200

    @delete
    Scenario: Delete a board
        Given Defines "DELETE" request to "/boards/pVlbXsHS"
        When The request is sent
        Then The status code should be 200
