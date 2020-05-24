@cards
@fixture.create.board @fixture.create.list @fixture.delete.list @fixture.delete.board
Feature: Cards

    @smoke @fixture.create.card @fixture.delete.card
    Scenario: Get a Card
        Given Defines "GET" request to "/cards/{card_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_get_schema.json"

    @acceptance @fixture.delete.card
    Scenario: Create a Card
        Given Defines "POST" request to "/cards/"
            | key    | value                          |
            | name   | My Test Card For POST Scenario |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_create_schema.json"
        And The body response must be contains
            | key     |  value                         |
            | name    | My Test Card For POST Scenario |

    @acceptance @fixture.create.card @fixture.delete.card
    Scenario: Update a Card
        Given Defines "PUT" request to "/cards/{card_id}"
            | key  |   value                        |
            | name |  My Test Card For PUT Scenario |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_update_schema.json"
        And The body response must be contains
            |key     | value                         |
            |name    | My Test Card For PUT Scenario |

    @acceptance @fixture.create.card
    Scenario: Delete a Card
        Given Defines "DELETE" request to "/cards/{card_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_delete_schema.json"

    @fixture.create.card @fixture.delete.card
    Scenario: Add a Member to a Card
        Given Get second member information
        And Defines "POST" request to "/cards/{card_id}/idMembers"
            |key     | value |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_remove_member_schema.json"

    @fixture.create.card @fixture.get.member @fixture.add.member.card @fixture.delete.card
    Scenario: Remove a Member from a Card
        Given Defines "DELETE" request to "/cards/{card_id}/idMembers/{member_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_add_member_schema.json"
    
    @smoke @authorization
    @fixture.create.card @fixture.get.member @fixture.add.member.card @fixture.delete.card
    Scenario Outline: "<action>" with wrong user token
        Given Defines "<verb>" request to "<endpoint>"
        And Set wrong user token
        When The request with wrong token is sent
        Then The status code should be 401
        Examples:
            | verb   | endpoint                               | action                      |
            | GET    | /cards/{card_id}                       | Get a Card                  |
            | PUT    | /cards/{card_id}                       | Update a Card               |
            | DELETE | /cards/{card_id}                       | Delete a Card               |
            | DELETE | /cards/{card_id}/idMembers/{member_id} | Remove a Member from a Card |

    @negative @fixture.create.card @fixture.delete.card
    Scenario Outline: Is not possible Get a Card with invalid parameters
        Given Defines "Verb" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
        | Verb | Endpoint                 | Response |
        | GET  | /cards/invalid_{card_id} | 400      |
        | GET  | /cards/{card_id}_invalid | 400      |
        | GET  | /cards/inv_{card_id}_lid | 400      |

    @negative
    Scenario Outline: Is not possible Create a Card with invalid parameters
        Given Defines "<Verb>" request to "/cards/"
            | key   | value          |
            | <Key> | <Value>        |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
        | Verb | Key         | Value      | Response |
        | POST | dueComplete | no_boolean | 400      |
        | POST | pos         | -1         | 400      |

    @negative @fixture.create.card @fixture.delete.card
    Scenario Outline: Is not possible Update a Card with invalid parameters
        Given Defines "<Verb>" request to "/cards/{card_id}"
            | key   | value          |
            | <Key> | <Value>        |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
        | Verb | Key    | Value      | Response |
        | PUT  | closed | no_boolean | 400      |
        | PUT  | pos    | -1         | 400      |

    @negative @fixture.create.card @fixture.delete.card
    Scenario Outline: Is not possible Delete a Card with invalid parameters
        Given Defines "<Verb>" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
        | Verb    | Endpoint                 | Response |
        | DELETE  | /cards/invalid_{card_id} | 400      |
        | DELETE  | /cards/{card_id}_invalid | 400      |
        | DELETE  | /cards/inva_{card_id}lid | 400      |
        | DELETE  | /cards/inva{card_id}_lid | 400      |
