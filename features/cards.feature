@fixture.create.board
@fixture.create.list
#@fixture.delete.list
@fixture.delete.board
Feature: C-R-U-D for Cards

    @fixture.create.card
    @fixture.delete.card
    Scenario: Get a Card
        Given Defines "GET" request to "/cards/{id}"
        When The request is sent
        Then The status code should be 200

    @fixture.delete.card
    Scenario: Create a Card
        Given Defines "POST" request to "/cards/"
            | key    | value             |
            | name   | MyTestCardForPOST |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            | key     |  value                   |
            | name    | MyTestCardForPOST        |

    @fixture.create.card
    @fixture.delete.card
    Scenario: Update a List
        Given Defines "PUT" request to "/cards/{id}"
            | key  |   value            |
            | name |  MyTestCardForPUT  |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            |key     | value                    |
            |name    | MyTestCardForPUT         |
    
    @fixture.create.card
    Scenario: Delete a list
        Given Defines "DELETE" request to "/cards/{id}"
        When The request is sent
        Then The status code should be 200
