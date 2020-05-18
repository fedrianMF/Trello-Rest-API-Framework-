"""Module for Members manage"""

from main.core.request_manager import RequestsManager
from main.core.utils.api_constants import HttpMethods


class MemberAPI:    # pylint: disable=R0903
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
