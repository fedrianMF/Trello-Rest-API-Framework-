@lists @fixture.create.board @fixture.delete.board
Feature: Lists

    @smoke @fixture.create.list @fixture.delete.list
    Scenario: Get a List
        Given Defines "GET" request to "/lists/{list_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_schema.json"

    @acceptance @fixture.delete.list
    Scenario: Create a List
        Given Defines "POST" request to "/lists/"
            | key    | value                    |
            | name   | MyTestListForPOST        |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_create_schema.json"
        And The body response must be contains
            | key     |  value                   |
            | name    | MyTestListForPOST        |

    @acceptance
    @fixture.create.list @fixture.delete.list
    Scenario: Update a List
        Given Defines "PUT" request to "/lists/{list_id}"
            | key  |   value            |
            | name |  MyTestListForPUT  |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_update_schema.json"
        And The body response must be contains
            |key     | value                    |
            |name    | MyTestListForPUT         |
    
    @acceptance @fixture.create.list
    Scenario: Delete a list
        Given Defines "PUT" request to "/lists/{list_id}/closed"
            | key   | value |
            | value | true  |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            |key     | value                     |
            |name    | List create at before tag |
    
    @acceptance @fixture.create.list
    Scenario: Get Actions for a List
        Given Defines "GET" request to "/lists/{list_id}/actions"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_actions.json"

    @acceptance @fixture.create.list
    Scenario: Get the Board a List is on
        Given Defines "GET" request to "/lists/{list_id}/board"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_board.json"

    @acceptance @fixture.create.list
    Scenario: Get Cards in a List
        Given Defines "GET" request to "/lists/{list_id}/cards"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_cards.json"
    
    @negative @fixture.create.list @fixture.delete.list
    Scenario Outline: Negative Get a List
        Given Defines "Verb" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
        | Verb | Endpoint                 | Response |
        | GET  | /lists/invalid_{list_id} | 400      |
        | GET  | /lists/{list_id}_invalid | 400      |
        | GET  | /lists/inv_{list_id}_lid | 400      |

    @negative
    Scenario Outline: Negative Create a List
        Given Defines "<Verb>" request to "/lists/"
            | key   | value          |
            | <Key> | <Value>        |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
        | Verb | Key           | Value      | Response |
        | POST | name          |            | 400      |
        | POST | idListSource  |            | 400      |
        | POST | pos           | -1         | 400      |

    @negative @fixture.create.list @fixture.delete.list
    Scenario Outline: Negative Update a List
        Given Defines "<Verb>" request to "/lists/{list_id}"
            | key   | value          |
            | <Key> | <Value>        |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
        | Verb | Key    | Value      | Response |
        | PUT  | name   |            | 400      |
        | PUT  | closed | no_boolean | 400      |
        | PUT  | pos    | -1         | 400      |

    @negative @fixture.create.list @fixture.delete.list
    Scenario Outline: Negative Delete a List
        Given Defines "PUT" request to "/lists/{list_id}/closed"
            | key   | value          |
            | <Key> | <Value>        |
        When The request is sent
        Then The status code should be 400
        And The schema is validated with "error_schema.json"
        Examples:
            | Key   | Value       |
            | value | no_boolean  |
            | value | -1          |
            | value | 2.25        |

    @smoke @authorization @fixture.create.list @fixture.delete.list
    Scenario Outline: "<action>" with wrong user token
        Given Defines "<verb>" request to "<endpoint>"
        And Set wrong user token
        When The request with wrong token is sent
        Then The status code should be 401
        Examples:
            | verb | endpoint                 | action                     |
            | GET  | /lists/{list_id}         | Get a List                 |
            | PUT  | /lists/{list_id}         | Update a List              |
            | PUT  | /lists/{list_id}/closed  | Delete a list              |
            | GET  | /lists/{list_id}/actions | Get Actions for a List     |
            | GET  | /lists/{list_id}/board   | Get the Board a List is on |
            | GET  | /lists/{list_id}/cards   | Get Cards in a List        |
