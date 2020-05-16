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
        :type request_manager: RequestManager
        :param board_id: request manager to create a board
        :type board_id: String
        """
        endpoint = "/boards/" + board_id
        request_manager.do_request(HttpMethods.DELETE.value, endpoint)

    @staticmethod
    def get_member_inf(request_manager):
        """ Get member information

        :param request_manager: request manager to get a member information
        :type request_manager: RequestManager
        """
        endpoint = "/members/me"
        status_code, json_response = \
            request_manager.do_request(HttpMethods.GET.value, endpoint)    # pylint: disable=W0612
        info_user = {
            "id": json_response['id'],
            "username": json_response['username']
        }
        return json_response['id'], info_user

    @staticmethod
    def add_member(request_manager, board_id, member_id):
        """ Add a member to board

        :param request_manager: request manager to add a member to board
        :type request_manager: RequestManager
        :param board_id: Board id to add a member
        :type board_id: String
        :param member_id: Member id for add to board
        :type board_id: String
        """
        body = {
            "type": "admin"
        }
        endpoint = f"/boards/{board_id}/members/{member_id}"
        request_manager.do_request(HttpMethods.PUT.value, endpoint, body)
