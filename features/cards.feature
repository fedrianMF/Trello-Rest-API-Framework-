@fixture.create.board
@fixture.create.list
@fixture.delete.board
Feature: Cards

    @fixture.create.card
    @fixture.delete.card
    Scenario: Get a Card
        Given Defines "GET" request to "/cards/{id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_get_schema.json"

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

    @fixture.create.card
    @fixture.delete.card
    Scenario: Update a Card
        Given Defines "PUT" request to "/cards/{id}"
            | key  |   value            |
            | name |  MyTestCardForPUT  |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_update_schema.json"
        And The body response must be contains
            |key     | value                    |
            |name    | MyTestCardForPUT         |
    
    @fixture.create.card
    Scenario: Delete a Card
        Given Defines "DELETE" request to "/cards/{id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "card_delete_schema.json"

    @fixture.create.card
    @fixture.get.member
    @fixture.create.member
    @fixture.delete.card
    Scenario: Add a Member to a Card
        Given Defines "POST" request to "/cards/{id}/idMembers"
            |key     | value                    |
        When The request is sent
        Then The status code should be 200
        #And The schema is validated with "card_delete_schema.json"

    @fixture.create.card
    @fixture.get.member
    @fixture.create.member
    @fixture.delete.card
    Scenario: Remove a Member from a Card
        Given Defines "POST" request to "/cards/{id}/idMembers"
            |key     | value                    |
        When The request is sent
        Then The status code should be 200
        #And The schema is validated with "card_delete_schema.json"
