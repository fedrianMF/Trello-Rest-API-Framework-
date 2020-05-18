"""Module for Boards manage"""

from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods


class Boards:
    """Utils for Boards endpoint"""

    @staticmethod
    def create_board(name, desc):
        """ Create a board

        :param name: Name for the new board
        :type name: String
        :param desc: Description for the new board
        :type desc: String
        """
        request_manager = RequestsManager()
        body = {
            "name": name,
            "desc": desc
        }
        status_code, json_response = request_manager.do_request(HttpMethods.POST.value,   # pylint: disable=W0612
                                                                "/boards/", body)
        return json_response['id']

    @staticmethod
    def delete_board(board_id):
        """ Create a board

        :param request_manager: request manager to create a board
        :type request_manager: RequestManager
        :param board_id: request manager to create a board
        :type board_id: String
        """
        request_manager = RequestsManager()
        endpoint = "/boards/" + board_id
        request_manager.do_request(HttpMethods.DELETE.value, endpoint)
