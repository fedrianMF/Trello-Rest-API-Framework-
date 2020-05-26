"""Module for Boards manage"""

from main.core.request_manager import RequestsManager as RM
from main.core.utils.api_constants import HttpMethods


class BoardsAPI:
    """Utils for Boards endpoint"""

    @staticmethod
    def create_board(name, description):
        """ Create a board

        :param name: Name for the new board
        :type name: String
        :param description: Description for the new board
        :type description: String
        """
        body = {
            "name": name,
            "desc": description
        }
        status_code, json_response = RM.get_instance().do_request(HttpMethods.POST.value,   # pylint: disable=W0612
                                                                  "/boards/", body)
        return json_response['id']

    @staticmethod
    def delete_board(board_id):
        """ Create a board

        :param board_id: request manager to create a board
        :type board_id: String
        """
        endpoint = "/boards/" + board_id
        RM.get_instance().do_request(HttpMethods.DELETE.value, endpoint)

    @staticmethod
    def add_member_to_board(board_id, member_id, type_user):
        """ Add a member to board

        :param board_id: Board id where Member will be added
        :type board_id: String
        :param member_id: Member id to add to Board
        :type member_id: String
        :param type_user: type user of Member
        :type type_user: String
        """
        body = {
            "type": type_user
        }
        endpoint = f"/boards/{board_id}/members/{member_id}"
        RM.get_instance().do_request(HttpMethods.PUT.value, endpoint, body)
