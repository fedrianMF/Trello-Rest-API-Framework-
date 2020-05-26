'''Module for lists'''

from main.core.request_manager import RequestsManager as RM
from main.core.utils.api_constants import HttpMethods


class ListsAPI:
    '''Utils for List endpoint'''
    @staticmethod
    def create_list(name, board_id):
        """ Create a list inside a board

        :param name: name of List
        :type name: String
        :param board_id: id of Board where list will create
        :type board_id: String
        """
        body = {
            "name": name,
            "idBoard": board_id
        }
        status_code, json_response = RM.get_instance().do_request(HttpMethods.POST.value,  # pylint: disable=W0612
                                                                  "/lists", body)
        return json_response['id']

    @staticmethod
    def archive_list(list_id, value):
        """ Archive a list

        :param list_id: id of list to archive
        :type list_id: String
        :param value: id of list
        :type value: Boolean
        """
        endpoint = f"/lists/{list_id}/closed"
        body = {
            "value": value
        }
        RM.get_instance().do_request(HttpMethods.PUT.value, endpoint, body)   # pylint: disable=W0612
