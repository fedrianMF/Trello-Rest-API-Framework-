@cards
@fixture.create.board @fixture.create.list @fixture.delete.list @fixture.delete.board
Feature: Cards

    @smoke @fixture.create.card @fixture.delete.card
    Scenario: Get a Card
        Given A "GET" request to "/cards/{card_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_get_schema.json"

    @smoke @fixture.delete.card
    Scenario: Create a Card
        Given A "POST" request to "/cards/"
            | key  | value                          |
            | name | My Test Card For POST Scenario |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_create_schema.json"
        And The body response must be contains
            | key               | value                          |
            | name              | My Test Card For POST Scenario |
            | desc              |                                |
            | closed            | False                          |
            | dueReminder       | None                           |
            | idAttachmentCover | None                           |
            | due               | None                           |
            | email             | None                           |

    @smoke @fixture.create.card @fixture.delete.card
    Scenario: Update a Card
        Given A "PUT" request to "/cards/{card_id}"
            | key  | value                         |
            | name | My Test Card For PUT Scenario |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_update_schema.json"
        And The body response must be contains
            | key               | value                         |
            | name              | My Test Card For PUT Scenario |
            | desc              |                               |
            | closed            | False                         |
            | dueReminder       | None                          |
            | idAttachmentCover | None                          |
            | due               | None                          |
            | email             | None                          |

    @smoke @fixture.create.card
    Scenario: Delete a Card
        Given A "DELETE" request to "/cards/{card_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_delete_schema.json"

    @acceptance @fixture.create.card @fixture.delete.card
    Scenario: Add a Member to a Card
        Given Get second member information
        And A "POST" request to "/cards/{card_id}/idMembers"
            | key | value |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_remove_member_schema.json"
        And The body response must be contains
            | key             | value        |
            | activityBlocked | False        |
            | username        | juanrivera89 |
            | initials        | ER           |

    @acceptance
    @fixture.create.card @fixture.get.member @fixture.add.member.card @fixture.delete.card
    Scenario: Remove a Member from a Card
        Given A "DELETE" request to "/cards/{card_id}/idMembers/{member_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_add_member_schema.json"

    @negative @authorization @fixture.create.card @fixture.delete.card
    Scenario Outline: "<action>" with wrong user token
        Given A "<verb>" request to "<endpoint>"
        And Set wrong user token with "<invalid>"
        When The request with wrong token is sent
        Then The status code should be 401
        Examples:
            | verb   | endpoint         | action        | invalid |
            | GET    | /cards/{card_id} | Get a Card    | ^+""    |
            | PUT    | /cards/{card_id} | Update a Card | &aksd   |
            | DELETE | /cards/{card_id} | Delete a Card | this    |

    @negative @authorization
    @fixture.create.card @fixture.get.member @fixture.add.member.card @fixture.delete.card
    Scenario: Remove a Member from a Card with wrong user token
        Given A "DELETE" request to "/cards/{card_id}/idMembers/{member_id}"
        And Set wrong user token with " 10293"
        When The request with wrong token is sent
        Then The status code should be 401

    @negative @fixture.create.card @fixture.delete.card
    Scenario Outline: Is not possible Get a Card with invalid parameters
        Given A "<Verb>" request to "<Endpoint>"
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
        Given A "<Verb>" request to "/cards/"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key         | Value   | Response |
            | POST | dueComplete | /112837 | 400      |
            | POST | pos         | -1      | 400      |

    @negative @fixture.create.card @fixture.delete.card
    Scenario Outline: Is not possible Update a Card with invalid parameters
        Given A "<Verb>" request to "/cards/{card_id}"
            | key   | value   |
            | <Key> | <Value> |
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb | Key    | Value | Response |
            | PUT  | closed | )($)  | 400      |
            | PUT  | pos    | -1    | 400      |

    @negative @fixture.create.card @fixture.delete.card
    Scenario Outline: Is not possible Delete a Card with invalid parameters
        Given A "<Verb>" request to "<Endpoint>"
        When The request is sent
        Then The status code should be <Response>
        And The schema is validated with "error_schema.json"
        Examples:
            | Verb   | Endpoint                    | Response |
            | DELETE | /cards/i{card_id}!"·"       | 400      |
            | DELETE | /cards/{card_id}98          | 400      |
            | DELETE | /cards/95{card_id} []       | 400      |
            | DELETE | /cards/inva{card_id}31{asd} | 400      |
