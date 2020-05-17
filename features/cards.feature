@fixture.create.board
@fixture.delete.board
@fixture.create.list
@fixture.delete.list
Feature: C-R-U-D for Cards

    @fixture.create.list
    @fixture.delete.list
    Scenario: Get a List
        Given Defines "GET" request to "/lists/{id}"
        When The request is sent
        Then The status code should be 200

    @fixture.delete.list
    Scenario: Create a List
        Given Defines "POST" request to "/lists/"
            | key    | value                    |
            | name   | MyTestListForPOST        |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            | key     |  value                   |
            | name    | MyTestListForPOST        |
            #| closed  | false                    |
            #| idBoard | 5ebdb48025f737334afb2d56 |

    @fixture.create.list
    @fixture.delete.list
    Scenario: Update a List
        Given Defines "PUT" request to "/lists/{id}"
            | key  |   value            |
            | name |  MyTestListForPUT  |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            |key     | value                    |
            |name    | MyTestListForPUT         |
            #|closed  | true                     |
            #|idBoard | 5ebddb511d1a7e4c088459ba |
    
    @fixture.create.list
    Scenario: Delete a list
        Given Defines "PUT" request to "/lists/{id}/closed"
            | key   | value |
            | value | true  |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            |key     | value                     |
            |name    | List create at before tag |
            #|closed  | true                     |
            #|idBoard | 5ebddb511d1a7e4c088459ba |
