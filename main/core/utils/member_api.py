"""Module for Members manage"""

from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods

REQUEST_MANAGER = RequestsManager(
    'https://api.trello.com/1/',
    'b874df46c1932f121f176125ecc3c52a',
    '01707264bda9655469300c5e744d5b7b1f0bb4aec548191bb8d524190ee380ad',
    'a1104796d5352c73d54794a0eb3bd3daa1a95fb769b253b19b0c1833cfb33679'
)


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
        endpoint = "/members/me"
        status_code, json_response = REQUEST_MANAGER.do_request(  # pylint: disable=W0612
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
        body = {
            "type": type_user
        }
        endpoint = f"/boards/{board_id}/members/{member_id}"
        REQUEST_MANAGER.do_request(HttpMethods.PUT.value, endpoint, body)
