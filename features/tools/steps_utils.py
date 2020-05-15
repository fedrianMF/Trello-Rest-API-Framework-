"""Module for constants"""
from enum import Enum
from main.core.utils.api_constants import HttpMethods


class CreateItems(Enum):
    """Enum Created to manage Http Methods constants"""
    @staticmethod
    def create_board(request_manager):
        """ Create a board

        :param request_manager: request manager to create a board
        :type request_manager: RequestManager
        """
        body = {
            "name": "test board create at before tags",
            "desc": "test description board"
        }
        status_code, json_response = request_manager.do_request(HttpMethods.POST.value,   # pylint: disable=W0612
                                                                "/boards/", body)
        return json_response['id']

    @staticmethod
    def delete_board(request_manager, board_id):
        """ Create a board

        :param request_manager: request manager to create a board
        :type context: RequestManager
        :param board_id: request manager to create a board
        :type board_id: String
        """
        endpoint = "/boards/" + board_id
        request_manager.do_request(HttpMethods.DELETE.value, endpoint)
