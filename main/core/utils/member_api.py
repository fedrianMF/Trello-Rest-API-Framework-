"""Module for Members manage"""

from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods


class Member:
    """Utils for Members endpoint"""

    @staticmethod
    def get_member_inf(key, token, oauth):
        """ Get member information

        :param key: key for the current user
        :type key: String
        :param token: token for the current user
        :type token: String
        :param oauth: oauth token for the current user
        :type oauth: String
        """
        request_manager = RequestsManager()
        endpoint = "/members/me"
        status_code, json_response = request_manager.do_request(  # pylint: disable=W0612
            HttpMethods.GET.value, endpoint,
            key=key,
            token=token, oauth_token=oauth)
        info_user = {
            "id": json_response['id'],
            "username": json_response['username']
        }
        return info_user

    @staticmethod
    def add_member(board_id, member_id, type_user):
        """ Add a member to board

        :param request_manager: request manager to add a member to board
        :type request_manager: RequestManager
        :param board_id: Board id to add a member
        :type board_id: String
        :param member_id: Member id for add to board
        :type board_id: String
        """
        request_manager = RequestsManager()
        body = {
            "type": type_user
        }
        endpoint = f"/boards/{board_id}/members/{member_id}"
        request_manager.do_request(HttpMethods.PUT.value, endpoint, body)
