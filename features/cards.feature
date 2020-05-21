@fixture.create.board
@fixture.create.list
@fixture.delete.list
@fixture.delete.board
Feature: Cards

    @smoke
    @fixture.create.card
    @fixture.delete.card
    Scenario: Get a Card
        Given Defines "GET" request to "/cards/{card}"
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
        Given Defines "PUT" request to "/cards/{card}"
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
        Given Defines "DELETE" request to "/cards/{card}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_delete_schema.json"

