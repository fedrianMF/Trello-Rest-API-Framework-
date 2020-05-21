@boards
Feature: Boards

    @smoke
    @fixture.create.board
    @fixture.delete.board
    Scenario: Get a specific board
        Given Defines "GET" request to "/boards/{board}"
        When The request is sent
        And The schema is validated with "board_get_schema.json"
        Then The status code should be 200

    @acceptance
    @fixture.delete.board
    Scenario: Create a board
        Given Defines "POST" request to "/boards/"
            | key  | value                                        |
            | name | test board                                   |
            | desc | here is a little description for API testing |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_schema.json"
        And The body response must be contains
            | key  | value                                        |
            | name | test board                                   |
            | desc | here is a little description for API testing |

    @acceptance
    @fixture.create.board
    @fixture.delete.board
    Scenario: Update a board
        Given Defines "PUT" request to "/boards/{board}"
            | key  | value                           |
            | name | new name test board             |
            | desc | here goes new board description |
        When The request is sent
        And The schema is validated with "board_update_schema.json"
        And The status code should be 200
        And The body response must be contains
            | key  | value                           |
            | name | new name test board             |
            | desc | here goes new board description |

    @acceptance
    @fixture.create.board
    Scenario: Delete a board
        Given Defines "DELETE" request to "/boards/{board}"
        When The request is sent
        And The schema is validated with "board_delete_schema.json"
        Then The status code should be 200

    @smoke
    @fixture.get.member
    @fixture.create.board
    @fixture.delete.board
    Scenario: Add a member to board
        Given Defines "PUT" request to "/boards/{board}/members/{member}"
            | key  | value |
            | type | admin |
        When The request is sent
        And The schema is validated with "board_members_schema.json"
        Then The status code should be 200
        And The body response must be contains
            | key  | value |
            | type | admin |

    @smoke
    @fixture.get.member
    @fixture.create.board
    @fixture.create.member
    @fixture.delete.board
    Scenario: Delete a member from board
        Given Defines "DELETE" request to "/boards/{board}/members/{member}"
        When The request is sent
        And The schema is validated with "board_delete_member_schema.json"
        Then The status code should be 200

    @negative
    Scenario: Create a board with invalid values
        Given Defines "POST" request to "/boards/"
            | key  | value                                        |
            | name |                                              |
            | desc | here is a little description for API testing |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative
    @fixture.create.board
    @fixture.delete.board
    Scenario: Update a board with invalid values
        Given Defines "PUT" request to "/boards/{boards}"
            | key  | value                                        |
            | name |                                              |
            | desc | here is a little description for API testing |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative
    @fixture.create.board
    @fixture.delete.board
    Scenario: Add member with invalid type
        Given Defines "PUT" request to "/boards/{board}/members/{member}"
            | key  | value   |
            | type | invalid |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative
    @fixture.create.board
    @fixture.get.member
    @fixture.delete.board
    Scenario: Delete unadd member from board
        Given Defines "DELETE" request to "/boards/{board}/members/{member}"
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 401
