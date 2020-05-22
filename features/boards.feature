@boards
Feature: Boards

    @smoke @fixture.create.board @fixture.delete.board
    Scenario: Get a specific board
        Given Defines "GET" request to "/boards/{board_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_schema.json"

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

    @acceptance @fixture.create.board @fixture.delete.board
    Scenario: Update a board
        Given Defines "PUT" request to "/boards/{board_id}"
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

    @acceptance @fixture.create.board
    Scenario: Delete a board
        Given Defines "DELETE" request to "/boards/{board_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_delete_schema.json"

    @smoke @fixture.create.board @fixture.delete.board
    Scenario: Add a member to board
        Given Get second member information
        And Defines "PUT" request to "/boards/{board_id}/members/{member_id}"
            | key  | value |
            | type | admin |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_members_schema.json"
        And The body response must be contains
            | key  | value |
            | type | admin |

    @smoke
    @fixture.get.member @fixture.create.board @fixture.add.member.board @fixture.delete.board
    Scenario: Delete a member from board
        Given Get second member information
        And Defines "DELETE" request to "/boards/{board_id}/members/{member_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_delete_member_schema.json"

    @acceptance
    @fixture.get.member @fixture.create.board @fixture.add.member.board @fixture.delete.board
    Scenario: Get memberships of a specific board
        Given Defines "GET" request to "/boards/{board_id}/memberships"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_members_schema.json"

    @acceptance @fixture.create.board @fixture.delete.board
    Scenario: Get Labels on a Board
        Given Defines "GET" request to "/boards/{board_id}/labels"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_labels_schema.json"

    @acceptance @fixture.create.board @fixture.delete.board
    Scenario: Get Lists on a Board
        Given Defines "GET" request to "/boards/{board_id}/lists"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_lists_schema.json"

    @smoke @authorization
    @fixture.create.board @fixture.get.member @fixture.add.member.board @fixture.delete.board
    Scenario Outline: "<action>" with wrong user token
        Given Defines "<verb>" request to "<endpoint>"
        And Set wrong user token
        When The request with wrong token is sent
        Then The status code should be 401
        Examples:
            | verb   | endpoint                               | action                              |
            | POST   | /boards/                               | Create a board                      |
            | GET    | /boards/{board_id}                     | Get a specific board                |
            | PUT    | /boards/{board_id}                     | Update a board                      |
            | DELETE | /boards/{board_id}                     | Delete a board                      |
            | PUT    | /boards/{board_id}/members/{member_id} | Add a member to board               |
            | DELETE | /boards/{board_id}/members/{member_id} | Delete a member from board          |
            | GET    | /boards/{board_id}/memberships         | Get memberships of a specific board |
            | GET    | /boards/{board_id}/labels              | Get Labels on a board               |
            | GET    | /boards/{board_id}/lists               | Get Lists on a board                |

    @negative @fixture.create.board @fixture.delete.board
    Scenario Outline: Negative Get a specific Board
        Given Defines "Verb" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Endpoint                   | Response |
            | GET  | /boards/invalid_{board_id} | 400      |
            | GET  | /boards/{board_id}_invalid | 400      |
            | GET  | /boards/inv_{board_id}_lid | 400      |

    @negative
    Scenario Outline: Negative Create a Board
        Given Defines "<Verb>" request to "/boards/"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key           | Value      | Response |
            | POST | name          |            | 400      |
            | POST | defaultLists  | no_boolean | 400      |
            | POST | defaultLabels | no_boolean | 400      |

    @negative @fixture.create.board @fixture.delete.board
    Scenario Outline: Negative Update a Board
        Given Defines "<Verb>" request to "/boards/{board_id}"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key              | Value      | Response |
            | PUT  | name             |            | 400      |
            | PUT  | closed           | no_boolean | 400      |
            | PUT  | prefs/selfJoin   | no_boolean | 400      |
            | PUT  | prefs/cardCovers |            | 400      |

    @negative @fixture.create.board @fixture.delete.board
    Scenario Outline: Negative Delete a Board
        Given Defines "<Verb>" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb   | Endpoint                   | Response |
            | DELETE | /boards/invalid_{board_id} | 400      |
            | DELETE | /boards/{board_id}_invalid | 400      |
            | DELETE | /boards/inva_{board_id}lid | 400      |
            | DELETE | /boards/inva{board_id}_lid | 400      |

