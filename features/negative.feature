#@fixture.create.board @fixture.delete.board
Feature: Negative
    
    @negative @fixture.create.board @fixture.delete.board
    Scenario Outline: Negative for Board
        Given Defines "<Verb>" request to "<Endpoint>"
            | key  | value          |
            | name | <Name>         |
            | desc | <Description>  |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400
        Examples:
        | Verb   | Endpoint                  | Name | Description                        |
        | POST   | /boards/                  |      | little description for API testing |
        | PUT    | /boards/{board_id}        |      | little description for API testing |
        | DELETE | /boards/invalid{board_id} |      |                                    |

    @negative
    @fixture.create.board
    @fixture.delete.board
    Scenario: Add member with invalid type
        Given Defines "PUT" request to "/boards/{board_id}/members/{member_id}"
            | key  | value   |
            | type | invalid |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400
    
    @negative @fixture.create.board @fixture.delete.board @fixture.create.list
    Scenario Outline: Negative for List
        Given Defines "<Verb>" request to "<Endpoint>"
            | key  | value          |
            | name | <Name>         |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400
        Examples:
        | Verb   | Endpoint                | Name |
        | POST   | /lists/                 |      |
        | PUT    | /lists/{list_id}        |      |

    @negative @fixture.create.list
    Scenario: Delete a List with invalid values
        Given Defines "PUT" request to "/lists/{list_id}/closed"
            | key   | value       |
            | value | no_boolean  |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative @fixture.create.board @fixture.delete.board @fixture.create.list @fixture.create.card
    Scenario Outline: Negative for Card
        Given Defines "<Verb>" request to "<Endpoint>"
            | key    | value                 |
            | name   | MyTestCardForNegative |
            | <key>  | no_boolean            |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400
        Examples:
        | Verb   | Endpoint                | key    |
        | POST   | /cards/                 | due    |
        | PUT    | /cards/{card_id}        | closed |
        | DELETE | /cards/invalid{card_id} ||
