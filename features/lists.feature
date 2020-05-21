@fixture.create.board
@fixture.delete.board
Feature: Lists

    @smoke
    @fixture.create.list
    @fixture.delete.list
    Scenario: Get a List
        Given Defines "GET" request to "/lists/{list_id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_schema.json"

    @acceptance
    @fixture.delete.list
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
    @fixture.create.list
    @fixture.delete.list
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
    
    @acceptance
    @fixture.create.list
    Scenario: Delete a list
        Given Defines "PUT" request to "/lists/{list_id}/closed"
            | key   | value |
            | value | true  |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            |key     | value                     |
            |name    | List create at before tag |
    
    @acceptance
    @fixture.create.list
    Scenario: Get Actions for a List
        Given Defines "GET" request to "/lists/{list_id}/actions"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_actions.json"

    @acceptance
    @fixture.create.list
    Scenario: Get the Board a List is on
        Given Defines "GET" request to "/lists/{list_id}/board"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_board.json"

    @acceptance
    @fixture.create.list
    Scenario: Get Cards in a List
        Given Defines "GET" request to "/lists/{list_id}/cards"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_cards.json"

    @negative
    Scenario: Create a List with invalid values
        Given Defines "POST" request to "/lists/"
            | key    | value                    |
            | name   |                          |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative
    @fixture.create.list
    Scenario: Update a List with invalid values
        Given Defines "PUT" request to "/lists/{list_id}"
            | key  |   value            |
            | name |                    |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400

    @negative
    @fixture.create.list
    Scenario: Delete a List with invalid values
        Given Defines "PUT" request to "/lists/{list_id}/closed"
            | key   | value       |
            | value | no_boolean  |
        When The request is sent
        And The schema is validated with "error_schema.json"
        Then The status code should be 400