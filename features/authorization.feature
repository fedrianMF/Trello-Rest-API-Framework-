@authorization
Feature: Authorization

    @smoke
    @fixture.get.member
    @fixture.create.board
    @fixture.create.list
    @fixture.create.card
    @fixture.add.member.card
    @fixture.delete.card
    @fixture.delete.list
    @fixture.add.member.board
    @fixture.delete.board
    Scenario Outline: <action> with wrong user token
        Given Defines "<verb>" request to "<endpoint>"
        And Set wrong user token
        When The request with wrong token is sent
        Then The status code should be 401

        Examples: Boards
            | verb   | endpoint                               | action board                        |
            | POST   | /boards/                               | Create a board                      |
            | GET    | /boards/{board_id}                     | Get a specific board                |
            | PUT    | /boards/{board_id}                     | Update a board                      |
            | DELETE | /boards/{board_id}                     | Delete a board                      |
            | PUT    | /boards/{board_id}/members/{member_id} | Add a member to board               |
            | DELETE | /boards/{board_id}/members/{member_id} | Delete a member from board          |
            | GET    | /boards/{board_id}/memberships         | Get memberships of a specific board |
            | GET    | /boards/{board_id}/labels              | Get Labels on a board               |
            | GET    | /boards/{board_id}/lists               | Get Lists on a board                |

        Examples: Lists
            | verb | endpoint                 | action                     |
            | GET  | /lists/{list_id}         | Get a List                 |
            | PUT  | /lists/{list_id}         | Update a List              |
            | PUT  | /lists/{list_id}/closed  | Delete a list              |
            | GET  | /lists/{list_id}/actions | Get Actions for a List     |
            | GET  | /lists/{list_id}/board   | Get the Board a List is on |
            | GET  | /lists/{list_id}/cards   | Get Cards in a List        |

        Examples: Cards
            | verb   | endpoint                               | action                      |
            | GET    | /cards/{card_id}                       | Get a Card                  |
            | PUT    | /cards/{card_id}                       | Update a Card               |
            | DELETE | /cards/{card_id}                       | Delete a Card               |
            | DELETE | /cards/{card_id}/idMembers/{member_id} | Remove a Member from a Card |




