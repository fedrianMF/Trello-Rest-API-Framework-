"""Module for Members manage"""

from main.core.request_manager import RequestsManager as RM
from main.core.utils.api_constants import HttpMethods


class MemberAPI:    # pylint: disable=R0903
    """Utils for Members endpoint"""

    @staticmethod
    def get_member_inf(auth2):
        """ Get member information

        :param auth2: oauth token for the current user
        :type auth2: String
        """
        endpoint = "/members/me"
        status_code, json_response = RM.get_instance().do_request(  # pylint: disable=W0612
            HttpMethods.GET.value, endpoint,
            auth=auth2)
        info_user = {
            "id": json_response['id'],
            "username": json_response['username']
        }
        return info_user
