@boards
Feature: Boards

    @smoke @fixture.create.board @fixture.delete.board
    Scenario: Get a Board
        Given A "GET" request to "/boards/{board_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_schema.json"
        And The body response must be contains
            | key            | value |
            | descData       | None  |
            | closed         | False |
            | idOrganization | None  |
            | idEnterprise   | None  |
            | pinned         | False |

    @smoke
    @fixture.delete.board
    Scenario: Create a Board
        Given A "POST" request to "/boards/"
            | key  | value                                        |
            | name | My Test Board For POST Scenario              |
            | desc | Here is a little description for API testing |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_schema.json"
        And The body response must be contains
            | key            | value                                        |
            | name           | My Test Board For POST Scenario              |
            | desc           | Here is a little description for API testing |
            | descData       | None                                         |
            | closed         | False                                        |
            | idOrganization | None                                         |
            | idEnterprise   | None                                         |
            | pinned         | False                                        |

    @smoke @fixture.create.board @fixture.delete.board
    Scenario: Update a Board
        Given A "PUT" request to "/boards/{board_id}"
            | key  | value                           |
            | name | My Test Board For PUT Scenario  |
            | desc | Here goes new board description |
        When The request is sent
        And The schema is validated with "board_update_schema.json"
        And The status code should be 200
        And The body response must be contains
            | key            | value                           |
            | name           | My Test Board For PUT Scenario  |
            | desc           | Here goes new board description |
            | descData       | None                            |
            | closed         | False                           |
            | idOrganization | None                            |
            | idEnterprise   | None                            |
            | pinned         | False                           |

    @smoke @fixture.create.board
    Scenario: Delete a Board
        Given A "DELETE" request to "/boards/{board_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_delete_schema.json"
        And The body response must be contains
            | key    | value |
            | _value | None  |

    @smoke @fixture.create.board @fixture.delete.board
    Scenario: Add a Member to Board
        Given Get second member information
        And A "PUT" request to "/boards/{board_id}/members/{member_id}"
            | key  | value |
            | type | admin |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_members_schema.json"
        And The body response must be contains
            | key         | value |
            | type        | admin |
            | unconfirmed | False |
            | deactivated | False |

    @acceptance
    @fixture.get.member @fixture.create.board @fixture.add.member.board @fixture.delete.board
    Scenario: Delete a Member from Board
        Given Get second member information
        And A "DELETE" request to "/boards/{board_id}/members/{member_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_delete_member_schema.json"
        And The body response must be contains
            | key            | value |
            | descData       | None  |
            | closed         | False |
            | idOrganization | None  |
            | idEnterprise   | None  |
            | pinned         | False |

    @acceptance
    @fixture.get.member @fixture.create.board @fixture.add.member.board @fixture.delete.board
    Scenario: Get memberships of a specific Board
        Given A "GET" request to "/boards/{board_id}/memberships"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_members_schema.json"
        And The body response must be contains
            | key         | value |
            | memberType  | admin |
            | unconfirmed | False |
            | deactivated | False |

    @acceptance @fixture.create.board @fixture.delete.board
    Scenario: Get Labels on a Board
        Given A "GET" request to "/boards/{board_id}/labels"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_labels_schema.json"
        And The body response must be contains
            | key   | value  |
            | name  |        |
            | color | green  |
            | color | yellow |
            | color | orange |
            | color | red    |

    @acceptance @fixture.create.board @fixture.delete.board
    Scenario: Get Lists on a Board
        Given A "GET" request to "/boards/{board_id}/lists"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "board_get_lists_schema.json"
        And The body response must be contains
            | key        | value |
            | closed     | False |
            | softLimit  | None  |
            | subscribed | False |

    @negative @authorization
    Scenario: Create a Board with wrong user token
        Given A "POST" request to "/boards/"
        And Set wrong user token with "invalid"
        When The request with wrong token is sent
        Then The status code should be 401

    @negative @authorization
    @fixture.create.board @fixture.delete.board
    Scenario Outline: "<action>" with wrong user token
        Given A "<verb>" request to "<endpoint>"
        And Set wrong user token with "<invalid>"
        When The request with wrong token is sent
        Then The status code should be 401
        Examples:
            | verb   | endpoint                  | action                | invalid |
            | GET    | /boards/{board_id}        | Get a Board           | ""      |
            | PUT    | /boards/{board_id}        | Update a Board        | ! exap  |
            | DELETE | /boards/{board_id}        | Delete a Board        | */!     |
            | GET    | /boards/{board_id}/labels | Get Labels on a Board | ...     |
            | GET    | /boards/{board_id}/lists  | Get Lists on a Board  | 6       |

    @negative @authorization
    @fixture.create.board @fixture.get.member @fixture.delete.board
    Scenario: Add a Member to Board with wrong user token
        Given A "PUT" request to "/boards/{board_id}/members/{member_id}"
        And Set wrong user token with "648"
        When The request with wrong token is sent
        Then The status code should be 401

    @negative @authorization
    @fixture.create.board @fixture.get.member @fixture.add.member.board @fixture.delete.board
    Scenario Outline: "<action>" with wrong user token
        Given A "<verb>" request to "<endpoint>"
        And Set wrong user token with "<invalid>"
        When The request with wrong token is sent
        Then The status code should be 401
        Examples:
            | verb   | endpoint                               | action                              | invalid |
            | DELETE | /boards/{board_id}/members/{member_id} | Delete a Member from Board          | Ç       |
            | GET    | /boards/{board_id}/memberships         | Get memberships of a specific Board | -.qp    |

    @negative @fixture.create.board @fixture.delete.board
    Scenario Outline: Is not possible Get a Board with invalid parameters
        Given A "Verb" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Endpoint                   | Response |
            | GET  | /boards/{board_id} 123u    | 400      |
            | GET  | /boards/1345%{board_id}es  | 400      |
            | GET  | /boards/inv_{board_id}_lid | 400      |

    @negative
    Scenario Outline: Is not possible Create a Board with invalid parameters
        Given A "<Verb>" request to "/boards/"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key           | Value      | Response |
            | POST | name          |            | 400      |
            | POST | defaultLists  | no_boolean | 400      |
            | POST | defaultLabels | bolean     | 400      |

    @negative @fixture.create.board @fixture.delete.board
    Scenario Outline: Is not possible Update a Board with invalid parameters
        Given A "<Verb>" request to "/boards/{board_id}"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key              | Value | Response |
            | PUT  | name             |       | 400      |
            | PUT  | closed           | flase | 400      |
            | PUT  | prefs/selfJoin   | !"·!" | 400      |
            | PUT  | prefs/cardCovers |       | 400      |

    @negative @fixture.create.board @fixture.delete.board
    Scenario Outline: Is not possible Delete a Board with invalid parameters
        Given A "<Verb>" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb   | Endpoint                   | Response |
            | DELETE | /boards/invalid_{board_id} | 400      |
            | DELETE | /boards/{board_id}_invalid | 400      |
            | DELETE | /boards/inva_{board_id}lid | 400      |
            | DELETE | /boards/inva{board_id}_lid | 400      |
