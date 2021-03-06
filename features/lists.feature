@lists
@fixture.create.board @fixture.delete.board
Feature: Lists

    @smoke @fixture.create.list @fixture.delete.list
    Scenario: Get a List
        Given A "GET" request to "/lists/{list_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_schema.json"
        And The body response must be contains
            | key    | value |
            | closed | False |


    @smoke @fixture.delete.list
    Scenario: Create a List
        Given A "POST" request to "/lists/"
            | key  | value                          |
            | name | My Test List For POST Scenario |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_create_schema.json"
        And The body response must be contains
            | key    | value                          |
            | name   | My Test List For POST Scenario |
            | closed | False                          |

    @smoke
    @fixture.create.list @fixture.delete.list
    Scenario: Update a List
        Given A "PUT" request to "/lists/{list_id}"
            | key  | value                         |
            | name | My Test List For PUT Scenario |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_update_schema.json"
        And The body response must be contains
            | key    | value                         |
            | name   | My Test List For PUT Scenario |
            | closed | False                         |

    @smoke @fixture.create.list
    Scenario: Delete a list
        Given A "PUT" request to "/lists/{list_id}/closed"
            | key   | value |
            | value | true  |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_delete_schema.json"
        And The body response must be contains
            | key    | value           |
            | name   | Before Tag List |
            | closed | True            |

    @acceptance @fixture.create.list
    Scenario: Get Actions for a List
        Given A "GET" request to "/lists/{list_id}/actions"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_actions.json"

    @acceptance @fixture.create.list
    Scenario: Get the Board a List is on
        Given A "GET" request to "/lists/{list_id}/board"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_board.json"
        And The body response must be contains
            | key            | value |
            | descData       | None  |
            | closed         | False |
            | idOrganization | None  |
            | idEnterprise   | None  |
            | pinned         | False |

    @acceptance @fixture.create.list
    Scenario: Get Cards in a List
        Given A "GET" request to "/lists/{list_id}/cards"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_cards.json"

    @negative @authorization @fixture.create.list @fixture.delete.list
    Scenario Outline: "<action>" with wrong user token
        Given A "<verb>" request to "<endpoint>"
        And Set wrong user token with "<invalid>"
        When The request with wrong token is sent
        Then The status code should be 401
        Examples:
            | verb | endpoint                 | action                     | invalid |
            | GET  | /lists/{list_id}         | Get a List                 | 0913481 |
            | PUT  | /lists/{list_id}         | Update a List              | 13 13   |
            | PUT  | /lists/{list_id}/closed  | Delete a list              | []      |
            | GET  | /lists/{list_id}/actions | Get Actions for a List     | some    |
            | GET  | /lists/{list_id}/board   | Get the Board a List is on | ---     |
            | GET  | /lists/{list_id}/cards   | Get Cards in a List        | @=ajdn  |

    @negative @fixture.create.list @fixture.delete.list
    Scenario Outline: Is not possible Get a List with invalid parameters
        Given A "Verb" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Endpoint                   | Response |
            | GET  | /lists/invalid_{list_id}   | 400      |
            | GET  | /lists/{list_id}123·       | 400      |
            | GET  | /lists/ !&={list_id} //234 | 400      |

    @negative
    Scenario Outline: Is not possible Create a List with invalid parameters
        Given A "<Verb>" request to "/lists/"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key          | Value | Response |
            | POST | name         |       | 400      |
            | POST | idListSource |       | 400      |
            | POST | pos          | -1    | 400      |

    @negative @fixture.create.list @fixture.delete.list
    Scenario Outline: Is not possible Update a List with invalid parameters
        Given A "<Verb>" request to "/lists/{list_id}"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key    | Value      | Response |
            | PUT  | name   |            | 400      |
            | PUT  | closed | no_boolean | 400      |
            | PUT  | pos    | -1         | 400      |

    @negative @fixture.create.list @fixture.delete.list
    Scenario Outline: Is not possible Delete a List with invalid parameters
        Given A "PUT" request to "/lists/{list_id}/closed"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be 400
        And The schema is validated with "error_schema.json"
        Examples:
            | Key   | Value      |
            | value | no_boolean |
            | value | -1         |
            | value | 2.25       |
