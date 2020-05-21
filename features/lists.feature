@fixture.create.board
@fixture.delete.board
Feature: Lists

    @fixture.create.list
    Scenario: Get a List
        Given Defines "GET" request to "/lists/{list}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_schema.json"

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

    @fixture.create.list
    Scenario: Update a List
        Given Defines "PUT" request to "/lists/{list}"
            | key  |   value            |
            | name |  MyTestListForPUT  |
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_update_schema.json"
        And The body response must be contains
            |key     | value                    |
            |name    | MyTestListForPUT         |
    
    @fixture.create.list
    Scenario: Delete a list
        Given Defines "PUT" request to "/lists/{list}/closed"
            | key   | value |
            | value | true  |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            |key     | value                     |
            |name    | List create at before tag |
