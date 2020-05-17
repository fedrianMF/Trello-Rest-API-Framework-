from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods

rm = RequestsManager(
        'https://api.trello.com/1/',
        'b874df46c1932f121f176125ecc3c52a',
        '01707264bda9655469300c5e744d5b7b1f0bb4aec548191bb8d524190ee380ad',
        'a1104796d5352c73d54794a0eb3bd3daa1a95fb769b253b19b0c1833cfb33679'
    )

class Member:
    @staticmethod
    def get_member_inf(key, token, oauth):
        """ Get member information

        :param request_manager: request manager to get a member information
        :type request_manager: RequestManager
        """
        endpoint = "/members/me"
        status_code, json_response = \
            rm.do_request(HttpMethods.GET.value, endpoint, key=key, token=token, oauth_token=oauth)    # pylint: disable=W0612
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
        rm.do_request(HttpMethods.PUT.value, endpoint, body)