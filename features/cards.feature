@fixture.create.board
@fixture.create.list
@fixture.delete.list
@fixture.delete.board
Feature: Cards

    @smoke
    @fixture.create.card
    @fixture.delete.card
    Scenario: Get a Card
        Given Defines "GET" request to "/cards/{card_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_get_schema.json"

    @acceptance
    @fixture.delete.card
    Scenario: Create a Card
        Given Defines "POST" request to "/cards/"
            | key    | value             |
            | name   | MyTestCardForPOST |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_create_schema.json"
        And The body response must be contains
            | key     |  value                   |
            | name    | MyTestCardForPOST        |

    @acceptance
    @fixture.create.card
    @fixture.delete.card
    Scenario: Update a Card
        Given Defines "PUT" request to "/cards/{card_id}"
            | key  |   value            |
            | name |  MyTestCardForPUT  |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_update_schema.json"
        And The body response must be contains
            |key     | value                    |
            |name    | MyTestCardForPUT         |

    @acceptance
    @fixture.create.card
    Scenario: Delete a Card
        Given Defines "DELETE" request to "/cards/{card_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_delete_schema.json"

    @fixture.create.card
    @fixture.get.member
    @fixture.delete.card
    Scenario: Add a Member to a Card
        Given Defines "POST" request to "/cards/{card_id}/idMembers"
            |key     | value                    |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_remove_member_schema.json"

    @fixture.create.card
    @fixture.get.member
    @fixture.create.card.member
    @fixture.delete.card
    Scenario: Remove a Member from a Card
        Given Defines "DELETE" request to "/cards/{card_id}/idMembers/{member_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_add_member_schema.json"

    @negative
    Scenario: Create a Card with invalid values
        Given Defines "POST" request to "/cards/"
            | key    | value                     |
            | name   | MyTestCardForNegativePOST |
            | due    | no_boolean                |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative
    @fixture.create.card
    Scenario: Update a Card with invalid values
        Given Defines "PUT" request to "/cards/{card_id}"
            | key    | value                    |
            | name   | MyTestCardForNegativePUT |
            | closed | no_boolean               |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative
    @fixture.create.card
    Scenario: Delete a Card with invalid values
        Given Defines "DELETE" request to "/cards/invalid{card_id}"
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400
