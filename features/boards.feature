@boards
Feature: C-R-U-D for Boards

    @get.boards
    Scenario: Get boards
        Given Defines "GET" request to "/boards/"
        When The request is sent
        #And The schema is validated with "schema.json"
        Then The status code should be 200

    @post.boards
    Scenario: Create a board
        Given Defines "POST" request to "/boards/"
            | key  | value                                        |
            | name | test board                                   |
            | desc | here is a little description for API testing |
        When The request is sent
        Then The status code should be 200
        # And The schema is validated with "schema.json"
        And The body response must be contains
            | key  | value                                        |
            | name | test board                                   |
            | desc | here is a little description for API testing |

    @update.boards
    Scenario: Update a board
        Given Defines "PUT" request to "/boards/"
            | key  | value                           |
            | name | new name test board             |
            | desc | here goes new board description |
        When The request is sent
        # And The schema is validated with "schema.json"
        And The status code should be 200
        And The body response must be contains
            | key  | value                           |
            | name | new name test board             |
            | desc | here goes new board description |

    @delete.boards
    Scenario: Delete a board
        Given Defines "DELETE" request to "/boards/"
        When The request is sent
        Then The status code should be 200
