'''Module for lists manage'''

from main.core.request_manager import RequestsManager as RM
from main.core.utils.api_constants import HttpMethods


class ListsAPI:
    '''Utils for List endpoint'''
    @staticmethod
    def create_list(board_id):
        """ Create a list inside a board

        :param board_id: id of Board where list will create
        :type board_id: String
        """
        body = {
            "name": "List create at before tag",
            "idBoard": board_id
        }
        status_code, json_response = RM.get_instance().do_request(HttpMethods.POST.value,  # pylint: disable=W0612
                                                                  "/lists", body)
        return json_response['id']

    @staticmethod
    def delete_list(list_id):
        """ Delete a list

        :param request_manager: request manager
        :type request_manager: RequestManager
        :param list_id: id of list
        :type board_id: String
        """
        request_manager = RequestsManager()
        endpoint = "/lists/{id}/closed"
        endpoint.replace("{id}", list_id)
        body = {
            "value": "true"
        }
        request_manager.do_request(HttpMethods.PUT.value, endpoint, body)   # pylint: disable=W0612