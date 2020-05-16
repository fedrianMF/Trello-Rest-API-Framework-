@boards
Feature: C-R-U-D for Boards

    @fixture.create.board
    @verify.board
    @fixture.delete.board
    Scenario: Get boards
        Given Defines "GET" request to "/boards/board_id"
        When The request is sent
        #And The schema is validated with "schema.json"
        Then The status code should be 200

    @create.board
    @delete.board
    @fixture.delete.board
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

    @fixture.create.board
    @update.board
    @fixture.delete.board
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

    @fixture.create.board
    @delete.board
    Scenario: Delete a board
        Given Defines "DELETE" request to "/boards/board_id"
        When The request is sent
        Then The status code should be 200

    @fixture.get.member
    @fixture.create.board
    @add.member
    @fixture.delete.board
    Scenario: Add a member to board
        Given Defines "PUT" request to "/boards/board_id/members/member_id"
            | key  | value |
            | type | admin |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            | key      | value                    |
            | type     | admin                    |

    @fixture.get.member
    @fixture.create.board
    @fixture.create.member
    @delete.member
    @fixture.delete.board
    Scenario: Delete a member from board
        Given Defines "DELETE" request to "/boards/board_id/members/member_id"
        When The request is sent
        Then The status code should be 200