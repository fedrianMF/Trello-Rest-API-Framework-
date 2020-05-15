@boards
Feature: C-R-U-D for Boards

    @get.boards
    Scenario: Get boards
        Given Defines "GET" request to "/boards/board_id"
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
        Given Defines "PUT" request to "/boards/board_id"
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
        Given Defines "DELETE" request to "/boards/board_id"
        When The request is sent
        Then The status code should be 200

    @put.members
    Scenario: Add a member to board
        Given Defines "PUT" request to "/boards/board_id/members/5c3e9a20eb00262f95cfa8ff"
            | key  | value |
            | type | admin |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            | key      | value                    |
            | id       | 5c3e9a20eb00262f95cfa8ff |
            | username | juanrivera89             |
            | type     | admin                    |