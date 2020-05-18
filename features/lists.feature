@fixture.create.board
@fixture.delete.board
Feature: C-R-U-D for Lists

    @fixture.create.list
    #@fixture.delete.list
    Scenario: Get a List
        Given Defines "GET" request to "/lists/{id}"
        When The request is sent
        Then The status code should be 200
        And The schema is validated with "list_get_schema.json"

    #@fixture.delete.list
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
    #@fixture.delete.list
    Scenario: Update a List
        Given Defines "PUT" request to "/lists/{id}"
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
        Given Defines "PUT" request to "/lists/{id}/closed"
            | key   | value |
            | value | true  |
        When The request is sent
        Then The status code should be 200
        And The body response must be contains
            |key     | value                     |
            |name    | List create at before tag |

    # @move.cards
    # Scenario: Move all Cards in List
    #     Given Defines "POST" request to "/lists/{id}/moveAllCards"
    #         | key     | value                    |
    #         | idBoard | 5ebddb511d1a7e4c088459ba |
    #         | idList  | 5ebde4d289a5bb4c62cb72c1 |
    #     When The request is sent
    #     Then The status code should be 200
    #     #request all moved lists [{id,idBoard,idList,pos},{},{}] 
    #     And Validates response body with
    #         |key     | value                    |
    #         |id      | 5ebddd1384818348082c1eea |
    #         |name    | TESTlistFELIX            |
    #         |closed  | true                     |
    #         |pos     | 8192                     |
    #         |idBoard | 5ebddb511d1a7e4c088459ba |

    # @delete.cards 
    # Scenario: Archive all cards in List
    #     Given Defines "POST" request to "/lists/{id}/archiveAllCards"
    #     When The request is sent
    #     Then The status code should be 200
    #     #request {}
    #     #And Validates response body with

    # @fixture.create.board
    # @fixture.create.list
    # @fixture.delete.list
    # Scenario: Move List to Board
    #     Given Defines "PUT" request to "/lists/{id}/idBoard"
    #         | key   | value                    |
    #         | value | 5ebddb511d1a7e4c088459ba |
    #     When The request is sent
    #     Then The status code should be 200
    #     And The body response must be contains
    #         |key     | value                    |
    #         #|id      | 5ebde4d289a5bb4c62cb72c1 |
    #         |name    | temporalList                      |
    #         #|closed  | false                    |
    #         #|pos     | 32768                    |
    #         |idBoard | 5ebddb511d1a7e4c088459ba |
